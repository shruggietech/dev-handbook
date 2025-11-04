# Security Best Practices

Security is critical for all software projects. This guide outlines essential security practices to protect your applications, data, and users.

## General Principles

### Defense in Depth
- Multiple layers of security controls
- Never rely on a single security measure
- Assume breach and limit damage

### Least Privilege
- Grant minimum necessary permissions
- Restrict access by default
- Review and revoke unused permissions

### Fail Securely
- Default to secure behavior on errors
- Don't expose sensitive information in errors
- Log security events for monitoring

## Authentication & Authorization

### Password Security

**Do:**
```python
# Use strong hashing (bcrypt, Argon2)
import bcrypt

password = b"user_password"
hashed = bcrypt.hashpw(password, bcrypt.gensalt())

# Verify password
if bcrypt.checkpw(password, hashed):
    print("Password matches")
```

**Don't:**
```python
# ❌ Never store plain text passwords
password = "user_password"
db.save(password)

# ❌ Don't use weak hashing (MD5, SHA1)
import hashlib
hashed = hashlib.md5(password.encode()).hexdigest()
```

### Password Requirements
- Minimum 12 characters (16+ recommended)
- Mix of uppercase, lowercase, numbers, symbols
- No common passwords (use password strength checkers)
- Support passphrases
- No maximum length restrictions (within reason)

### Multi-Factor Authentication (MFA)
- Implement for sensitive operations
- Support TOTP (Time-based One-Time Password)
- Offer backup codes
- Don't rely solely on SMS

### JWT Best Practices

```javascript
// Use strong secret
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET; // Long, random string

// Set expiration
const token = jwt.sign(
  { userId: user.id },
  secret,
  { expiresIn: '1h' }
);

// Verify token
try {
  const decoded = jwt.verify(token, secret);
} catch (error) {
  // Invalid or expired token
}
```

**Best Practices:**
- Use short expiration times
- Implement refresh tokens
- Store tokens securely (httpOnly cookies)
- Never expose secrets in client-side code
- Rotate signing keys periodically

### Session Management

```javascript
// Secure session configuration
app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: true,        // HTTPS only
    httpOnly: true,      // No JavaScript access
    maxAge: 3600000,     // 1 hour
    sameSite: 'strict'   // CSRF protection
  }
}));
```

## Input Validation

### Validate All Inputs

```javascript
// Use validation library
const Joi = require('joi');

const schema = Joi.object({
  email: Joi.string().email().required(),
  age: Joi.number().integer().min(0).max(120),
  username: Joi.string().alphanum().min(3).max(30).required()
});

const { error, value } = schema.validate(req.body);
if (error) {
  return res.status(400).json({ error: error.details[0].message });
}
```

### Sanitize Inputs

```javascript
// Remove dangerous characters
const sanitizeHtml = require('sanitize-html');

const clean = sanitizeHtml(userInput, {
  allowedTags: ['b', 'i', 'em', 'strong'],
  allowedAttributes: {}
});
```

### Prevent Injection Attacks

**SQL Injection Prevention:**
```python
# ✅ Use parameterized queries
cursor.execute(
    "SELECT * FROM users WHERE email = %s",
    (email,)
)

# ❌ Never concatenate user input
cursor.execute(
    f"SELECT * FROM users WHERE email = '{email}'"
)
```

**NoSQL Injection Prevention:**
```javascript
// ✅ Validate and sanitize
const userId = req.body.userId;
if (!/^[0-9a-fA-F]{24}$/.test(userId)) {
  return res.status(400).json({ error: 'Invalid ID' });
}

// ❌ Direct use of user input
db.collection.find({ _id: req.body.userId });
```

**Command Injection Prevention:**
```python
# ✅ Use subprocess with arguments list
import subprocess
subprocess.run(['ls', '-l', user_directory])

# ❌ Shell injection vulnerable
subprocess.run(f'ls -l {user_directory}', shell=True)
```

## Cross-Site Scripting (XSS)

### Output Encoding

```javascript
// Use templating engines with auto-escaping
// EJS, Handlebars, React, Vue (default behavior)

// Manual encoding when needed
function escapeHtml(text) {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}
```

### Content Security Policy (CSP)

```javascript
// Set CSP headers
app.use((req, res, next) => {
  res.setHeader(
    'Content-Security-Policy',
    "default-src 'self'; " +
    "script-src 'self' 'unsafe-inline'; " +
    "style-src 'self' 'unsafe-inline'; " +
    "img-src 'self' data: https:; " +
    "font-src 'self';"
  );
  next();
});
```

## Cross-Site Request Forgery (CSRF)

### CSRF Protection

```javascript
// Use CSRF middleware
const csrf = require('csurf');
const csrfProtection = csrf({ cookie: true });

app.get('/form', csrfProtection, (req, res) => {
  res.render('form', { csrfToken: req.csrfToken() });
});

app.post('/process', csrfProtection, (req, res) => {
  // Process form
});
```

```html
<!-- Include CSRF token in forms -->
<form method="POST" action="/process">
  <input type="hidden" name="_csrf" value="<%= csrfToken %>">
  <!-- Other fields -->
</form>
```

### SameSite Cookies

```javascript
res.cookie('sessionId', token, {
  sameSite: 'strict',  // Prevents CSRF
  secure: true,
  httpOnly: true
});
```

## Secrets Management

### Environment Variables

```bash
# .env file (never commit!)
DATABASE_URL=postgresql://user:pass@localhost/db
API_KEY=your-secret-api-key
JWT_SECRET=very-long-random-string
```

```javascript
// Load environment variables
require('dotenv').config();

const apiKey = process.env.API_KEY;
```

### Secrets in CI/CD

```yaml
# GitHub Actions
jobs:
  deploy:
    steps:
      - name: Deploy
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: npm run deploy
```

### Key Management

- Use dedicated secrets managers (AWS Secrets Manager, Azure Key Vault, HashiCorp Vault)
- Rotate secrets regularly
- Use different secrets for dev/staging/production
- Never hardcode secrets in source code
- Don't log secrets

## HTTPS/TLS

### Force HTTPS

```javascript
// Redirect HTTP to HTTPS
app.use((req, res, next) => {
  if (!req.secure && req.get('x-forwarded-proto') !== 'https') {
    return res.redirect('https://' + req.get('host') + req.url);
  }
  next();
});
```

### Security Headers

```javascript
const helmet = require('helmet');

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"]
    }
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  }
}));
```

### Certificate Management

- Use Let's Encrypt for free SSL/TLS certificates
- Enable HTTP Strict Transport Security (HSTS)
- Monitor certificate expiration
- Use strong cipher suites

## API Security

### Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
```

### API Keys

```javascript
// Validate API key middleware
function validateApiKey(req, res, next) {
  const apiKey = req.header('X-API-Key');
  
  if (!apiKey || !isValidApiKey(apiKey)) {
    return res.status(401).json({ error: 'Invalid API key' });
  }
  
  next();
}

app.use('/api/', validateApiKey);
```

### CORS Configuration

```javascript
const cors = require('cors');

app.use(cors({
  origin: process.env.ALLOWED_ORIGINS.split(','),
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
```

## Dependency Security

### Keep Dependencies Updated

```bash
# Check for vulnerabilities
npm audit
pip-audit

# Update packages
npm update
pip install --upgrade package-name

# Use Dependabot or Renovate for automated updates
```

### Lock Dependencies

```json
// package-lock.json, poetry.lock, Gemfile.lock
// Ensures consistent versions across environments
```

### Minimal Dependencies

- Only install necessary packages
- Review package code before using
- Check package popularity and maintenance
- Verify package integrity (checksums)

## Data Protection

### Encryption at Rest

```python
# Encrypt sensitive data before storage
from cryptography.fernet import Fernet

key = Fernet.generate_key()
cipher = Fernet(key)

encrypted = cipher.encrypt(b"sensitive data")
decrypted = cipher.decrypt(encrypted)
```

### Encryption in Transit

- Always use HTTPS/TLS
- Use secure WebSocket (wss://)
- Encrypt database connections
- Use VPN for sensitive operations

### Data Minimization

- Collect only necessary data
- Delete data when no longer needed
- Anonymize logs and analytics
- Implement data retention policies

### PII Protection

- Identify and protect Personally Identifiable Information
- Comply with GDPR, CCPA regulations
- Implement right to deletion
- Encrypt PII in storage and transit
- Audit access to PII

## Logging and Monitoring

### Security Logging

```javascript
const winston = require('winston');

const logger = winston.createLogger({
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'security.log' })
  ]
});

// Log security events
logger.info('User login', { userId, ip, timestamp });
logger.warn('Failed login attempt', { email, ip, timestamp });
logger.error('Unauthorized access attempt', { userId, resource, timestamp });
```

### What to Log

✅ **Do log:**
- Authentication events (success/failure)
- Authorization failures
- Input validation failures
- Rate limit violations
- Security configuration changes
- Data access (for audit trails)

❌ **Don't log:**
- Passwords (even hashed)
- Session tokens
- API keys
- Credit card numbers
- Other sensitive data

### Monitoring

- Set up alerts for suspicious activities
- Monitor failed login attempts
- Track unusual API usage patterns
- Monitor system resource usage
- Review logs regularly

## Error Handling

### Secure Error Messages

```javascript
// ✅ Generic error for users
res.status(500).json({ 
  error: 'An error occurred. Please try again later.' 
});

// Log detailed error for developers
logger.error('Database connection failed', { 
  error: err.message,
  stack: err.stack,
  timestamp: new Date()
});

// ❌ Don't expose internal details
res.status(500).json({ 
  error: err.message,  // May contain sensitive info
  stack: err.stack     // Reveals application structure
});
```

## Security Testing

### Static Analysis

```bash
# JavaScript
npm install -g eslint eslint-plugin-security
eslint --plugin security .

# Python
bandit -r src/

# PowerShell
Invoke-ScriptAnalyzer -Path . -Recurse
```

### Dependency Scanning

```bash
# npm
npm audit

# Python
safety check
pip-audit

# Snyk
snyk test
```

### Penetration Testing

- Regular security audits
- Use tools like OWASP ZAP, Burp Suite
- Test for OWASP Top 10 vulnerabilities
- Conduct code reviews with security focus
- Consider bug bounty programs

## Incident Response

### Preparation

1. Have incident response plan
2. Maintain contact list
3. Document systems and dependencies
4. Keep backups current and tested
5. Practice incident response

### Response Steps

1. **Detect** - Identify the incident
2. **Contain** - Limit the damage
3. **Eradicate** - Remove the threat
4. **Recover** - Restore normal operations
5. **Learn** - Post-incident review

### Communication

- Notify affected users
- Report to authorities if required
- Maintain transparency
- Document everything

## Security Checklist

### Before Deployment

- [ ] All dependencies updated
- [ ] Security audit completed
- [ ] Secrets not in code
- [ ] HTTPS enabled
- [ ] Security headers configured
- [ ] Input validation implemented
- [ ] Authentication/authorization working
- [ ] Rate limiting configured
- [ ] Logging and monitoring setup
- [ ] Error handling reviewed
- [ ] Backups configured
- [ ] Incident response plan ready

### Regular Maintenance

- [ ] Review access logs
- [ ] Update dependencies
- [ ] Rotate secrets
- [ ] Review user permissions
- [ ] Test backups
- [ ] Security patches applied
- [ ] Audit third-party integrations

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Security Headers](https://securityheaders.com/)
- [Have I Been Pwned](https://haveibeenpwned.com/)

## Reporting Security Issues

If you discover a security vulnerability:

1. **Do not** open a public issue
2. Email security@shruggietech.com
3. Include detailed description
4. Provide steps to reproduce
5. Allow time for fix before disclosure

We take security seriously and appreciate responsible disclosure.
