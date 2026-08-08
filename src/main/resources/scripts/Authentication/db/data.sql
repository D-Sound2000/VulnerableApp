-- Level 1: SQL Injection
-- Real password: 'not_needed_for_sqli'
INSERT INTO auth_users VALUES (1, 'admin_sqli', '$2a$10$K1Ey.b/ZL5.HSQ2JYccEXOLtXER3LWTL0Psn8FeMaUG940uDHrkdO', NULL, 'BCRYPT', 1, 'admin_sqli@example.com', 'ADMIN');

-- Level 2: Sensitive Data Logging
-- Real password: 'v9K#2mLp!8zQ'
INSERT INTO auth_users VALUES (2, 'admin_logs', '$2a$10$9kSbKNoHdbYkD/qrdaiu0ugxPMhChUuYlcUIRW79vsrWBkWOpEVFq', NULL, 'BCRYPT', 2, 'admin_logs@example.com', 'ADMIN');

-- Level 3: Plaintext Storage
-- Real password: 'b7X$4nRj-6mW'
INSERT INTO auth_users VALUES (3, 'admin_plain', '$2a$10$53qqz.puYjwPn8gAxduSY.IN8TXKdizsXz.IPy6WOIfaeyA4vsgCa', NULL, 'BCRYPT', 3, 'admin_plain@example.com', 'ADMIN');

-- Level 4: MD5 Hashing (f2C@9tYk*1hP)
INSERT INTO auth_users VALUES (4, 'admin_md5', '0168b6037606df265be7f1f5d9c0e7fe', NULL, 'MD5', 4, 'admin_md5@example.com', 'ADMIN');

-- Level 5: SHA1 Hashing (x5B&3gHq+7vS)
INSERT INTO auth_users VALUES (5, 'admin_sha1', '632e10860bd26278451d3f89d1c46f180e5623e0', NULL, 'SHA1', 5, 'admin_sha1@example.com', 'ADMIN');

-- Level 6: SHA-256 (No Salt) (m8D!4kLr#2jZ)
INSERT INTO auth_users VALUES (6, 'admin_sha256', '8b8eca84f7e2b04f531749f999c3bf9e3f045bab78f4c8a451fa70929b3c3946', NULL, 'SHA256', 6, 'admin_sha256@example.com', 'ADMIN');

-- Level 7: Salted SHA-256 (q1W%6nTp^8vM with Salt s9A#2zLk)
INSERT INTO auth_users VALUES (7, 'admin_enum', '71ad23cc508b5658f0bc21d8323f55521be98ca951e83a4a4d15641a3ca2b8a4', 's9A#2zLk', 'SHA256', 7, 'admin_enum@example.com', 'ADMIN');

-- Level 8: Weak Password + Bcrypt (Xr7$mQ2!vZ9-tK4w)
-- Bcrypt hash for 'Xr7$mQ2!vZ9-tK4w'
INSERT INTO auth_users VALUES (8, 'admin_weak', '$2a$10$yHzqVnYPX/B5ilvXHXFJrO0Dr5anZ3uPyb.k6cvAV04DJLRCT5KtC', NULL, 'BCRYPT', 8, 'admin_weak@example.com', 'ADMIN');

-- Level 9: Secure (Bcrypt + Generic Error) (9fG#2hJk*LmN!8qR)
-- Bcrypt hash for '9fG#2hJk*LmN!8qR'
INSERT INTO auth_users VALUES (9, 'admin_secure', '$2a$10$1WiFUNqUY/vHTzR2QtuMQuzCLK3aZEdjEUpqS4msXOevaCz7Wobe.', NULL, 'BCRYPT', 9, 'admin_secure@example.com', 'ADMIN');

-- Level 10: BCrypt with a cost factor of 12
-- Bcrypt hash (cost 12) for 'Hn5^pW8@dR3!yL6z'
INSERT INTO auth_users VALUES (10, 'admin_lowcost', '$2a$12$BiO43Ip7luSJ5WJBv.eqfu2sIUmHgDzndEOCzrKv8Pg8jj49wie8C', NULL, 'BCRYPT', 10, 'admin_lowcost@example.com', 'ADMIN');
