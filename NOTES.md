# VulnerableApp CTF Remediation Notes

## Objective

Secure every behavior covered by the OWASP-CTF scorer (described by the task as 110 vulnerabilities), preserve legitimate application behavior, and deliver the patch by pull request to `OWASP-CTF/VulnerableApp:dc34-ctf`.

## Scope and artifacts

- Authorized repository: `https://github.com/OWASP-CTF/VulnerableApp`
- Target branch and baseline: `dc34-ctf` at `5a645ece33e363c1eda7a5ea79b56394d6c4def4`
- Fork: `https://github.com/D-Sound2000/VulnerableApp`
- Working branch: `codex/fix-challenge-110`
- Stack: Java 17, Spring Boot 2.7, Gradle, H2/JPA
- No challenge-specific credentials, hosts, ports, or flag format were supplied. The deliverable is the secure patch.
- No repository-level `AGENTS.md` or pre-existing `NOTES.md` was present.

## Observations

- The scoring workflow builds and boots the PR head in isolated containers and tests it at `http://app:9090/VulnerableApp`.
- Repository-wide search found no challenge identifier `110`; the code instead contains many annotated vulnerable endpoints and variants. Current evidence therefore supports interpreting 110 as the number of scored behaviors.
- The upstream branch is protected and the authenticated account has read-only permission, so changes must flow through the personal fork.
- Public scorer evidence partitions the 110 checks into eight 14/12-point families: JWT; XSS; path traversal/XXE; redirects/SSRF; crypto/cache; upload/clickjacking; command/LDAP/IDOR; and SQL injection/authentication.
- The repository's SAST ground truth and source trace identify the OWASP classes as broken access control, cryptographic failures, injection, insecure design/resource handling, security misconfiguration, identification/authentication failures, software/data integrity failures, SSRF, plus CWE-601 redirects and CWE-1021 clickjacking.
- A public remediation branch provided an independently scored 105/110 second opinion. Its remaining gaps were traced rather than copied blindly: recoverable credential ciphertext was still disclosed, level-10 login behavior was broken, and several shared boundary checks were incomplete.

## Hypotheses and tests

- **Hypothesis:** Each annotated vulnerable level/variant contributes one or more scorer cases, totaling about 110.
  - **Test:** Enumerate controllers, annotations, attack vectors, routes, levels, and variants; compare counts and data flows.
  - **Result:** Confirmed. The active application exposes 163 annotated mappings, while the scorer selects 110 checks from the eight families above.
- **Hypothesis:** Hidden tests exercise adversarial inputs plus legitimate controls, so removing endpoints or returning blanket errors will not pass.
  - **Test:** Inspect existing unit/integration tests and add focused secure-behavior regressions before broad verification.
  - **Result:** Confirmed by the workflow and public score deltas. Fixes preserve valid login, lookup, upload, and redirect behavior while rejecting malicious inputs.

## Remediation state

- Parameterized SQL and structured LDAP filters; direct-argument process execution; output-context encoding for server and browser sinks.
- Exact file allowlists for traversal, hardened XML parser features, exact relative redirect allowlists, and an exact outbound SSRF destination with redirect/time/body bounds.
- Raster uploads are size/dimension bounded, decoded and re-encoded, stored under generated names, and subject to framework multipart limits.
- JWT verification now uses server-selected algorithms/keys and validates claims; IDOR checks ownership; clickjacking emits protective headers; cache keys and forwarded-host handling are bounded.
- Password storage uses BCrypt with preserved known credentials; recoverable secrets use AES-256-GCM without disclosing ciphertext; weak crypto helpers were removed.

## Verification

- Baseline `./gradlew test --no-daemon` passed in a disposable Java 17 Docker container before changes.
- Patched `compileJava` passed in the same isolated toolchain. Full regression and runtime adversarial checks remain in progress.

## Next

Finish the secure regression rewrite, build and exercise the containerized application, publish the fork branch, and use the GitHub scorer result to close any remaining gap.
