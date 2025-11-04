# Node.js API Template

A production-ready RESTful API template built with Node.js and Express. Features TypeScript support, authentication, database integration, and comprehensive testing.

## Features

- ✅ Express.js web framework
- ✅ TypeScript support (optional)
- ✅ RESTful API structure
- ✅ JWT authentication
- ✅ Database integration (PostgreSQL/MongoDB)
- ✅ Request validation
- ✅ Error handling middleware
- ✅ API documentation (Swagger/OpenAPI)
- ✅ Unit and integration tests
- ✅ Docker support
- ✅ GitHub Actions CI/CD

## Quick Start

### Prerequisites

- Node.js 18+ and npm
- PostgreSQL or MongoDB (optional)
- Docker (optional)

### Installation

```bash
# Download template
cp -r templates/nodejs-api my-api
cd my-api

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Edit .env with your configuration
nano .env
```

### Configuration

Edit `.env` file:

```env
# Server
NODE_ENV=development
PORT=3000

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/mydb

# Authentication
JWT_SECRET=your-super-secret-jwt-key
JWT_EXPIRES_IN=7d

# CORS
CORS_ORIGIN=http://localhost:3000
```

### Run Development Server

```bash
# Start in development mode (with hot reload)
npm run dev

# Or with TypeScript
npm run dev:ts
```

API will be available at `http://localhost:3000`

## Project Structure

```
nodejs-api/
├── src/
│   ├── controllers/       # Route controllers
│   ├── models/           # Data models
│   ├── routes/           # API routes
│   ├── middleware/       # Custom middleware
│   ├── services/         # Business logic
│   ├── utils/            # Helper functions
│   ├── config/           # Configuration files
│   └── app.js            # Express app setup
├── tests/
│   ├── unit/             # Unit tests
│   └── integration/      # Integration tests
├── docs/
│   └── api.yaml          # OpenAPI specification
├── .env.example          # Environment variables template
├── .gitignore
├── package.json
├── Dockerfile
└── README.md
```

## API Endpoints

### Health Check
```http
GET /api/health
```

### Authentication
```http
POST /api/auth/register
POST /api/auth/login
POST /api/auth/refresh
```

### Users
```http
GET    /api/users
GET    /api/users/:id
POST   /api/users
PUT    /api/users/:id
DELETE /api/users/:id
```

### Example Request

```bash
# Register a new user
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "SecurePass123",
    "name": "John Doe"
  }'

# Get all users (requires authentication)
curl http://localhost:3000/api/users \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Database Setup

### PostgreSQL

```bash
# Create database
createdb myapi

# Run migrations
npm run migrate

# Seed database (optional)
npm run seed
```

### MongoDB

```bash
# Ensure MongoDB is running
mongod

# Database will be created automatically on first connection
```

## Testing

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run specific test file
npm test -- tests/unit/users.test.js

# Watch mode
npm run test:watch
```

## Building for Production

```bash
# Build (if using TypeScript)
npm run build

# Start production server
npm start

# Or with PM2
pm2 start ecosystem.config.js
```

## Docker

### Build and Run

```bash
# Build image
docker build -t my-api .

# Run container
docker run -p 3000:3000 --env-file .env my-api

# Or use Docker Compose
docker-compose up
```

### Docker Compose

```yaml
version: '3.8'
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
  
  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=myapi
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres-data:/var/lib/postgresql/data

volumes:
  postgres-data:
```

## API Documentation

### Swagger UI

Access interactive API documentation:

```
http://localhost:3000/api-docs
```

### Generate Documentation

```bash
# Update OpenAPI spec
npm run docs:generate

# Validate spec
npm run docs:validate
```

## Code Style

### Linting

```bash
# Run ESLint
npm run lint

# Fix auto-fixable issues
npm run lint:fix
```

### Formatting

```bash
# Format with Prettier
npm run format

# Check formatting
npm run format:check
```

## Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `NODE_ENV` | Environment (development/production) | development | No |
| `PORT` | Server port | 3000 | No |
| `DATABASE_URL` | Database connection string | - | Yes |
| `JWT_SECRET` | JWT signing secret | - | Yes |
| `JWT_EXPIRES_IN` | JWT expiration time | 7d | No |
| `CORS_ORIGIN` | Allowed CORS origins | * | No |
| `LOG_LEVEL` | Logging level (error/warn/info/debug) | info | No |

## Customization

### Add New Endpoint

1. **Create Controller** (`src/controllers/items.controller.js`):
```javascript
exports.getAll = async (req, res) => {
  const items = await Item.find();
  res.json({ data: items });
};
```

2. **Create Route** (`src/routes/items.routes.js`):
```javascript
const express = require('express');
const router = express.Router();
const itemsController = require('../controllers/items.controller');

router.get('/', itemsController.getAll);

module.exports = router;
```

3. **Register Route** (`src/app.js`):
```javascript
app.use('/api/items', require('./routes/items.routes'));
```

### Add Middleware

Create in `src/middleware/`:

```javascript
// src/middleware/rateLimiter.js
const rateLimit = require('express-rate-limit');

module.exports = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
```

Apply to routes:
```javascript
const rateLimiter = require('./middleware/rateLimiter');
app.use('/api/', rateLimiter);
```

## Deployment

### Heroku

```bash
# Login to Heroku
heroku login

# Create app
heroku create my-api

# Set environment variables
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=your-secret

# Deploy
git push heroku main

# Run migrations
heroku run npm run migrate
```

### AWS (EC2)

```bash
# SSH into EC2 instance
ssh -i key.pem ec2-user@your-instance

# Install Node.js
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install nodejs

# Clone and setup
git clone your-repo
cd your-repo
npm install
npm run build

# Use PM2 for process management
npm install -g pm2
pm2 start ecosystem.config.js
pm2 startup
pm2 save
```

## Troubleshooting

### Port Already in Use
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 PID
```

### Database Connection Issues
- Verify DATABASE_URL is correct
- Check database is running
- Ensure network connectivity
- Check firewall rules

### JWT Token Errors
- Verify JWT_SECRET is set
- Check token expiration
- Ensure Bearer token format

## Security Best Practices

- ✅ Use environment variables for secrets
- ✅ Implement rate limiting
- ✅ Validate all inputs
- ✅ Use HTTPS in production
- ✅ Keep dependencies updated
- ✅ Implement proper error handling
- ✅ Use security headers (helmet)
- ✅ Enable CORS properly
- ✅ Hash passwords (bcrypt)
- ✅ Sanitize database queries

## Performance Tips

- Use connection pooling
- Implement caching (Redis)
- Enable compression
- Optimize database queries
- Use CDN for static assets
- Monitor with APM tools
- Implement pagination
- Use database indexing

## Resources

- [Express.js Documentation](https://expressjs.com/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [REST API Design Guide](https://restfulapi.net/)
- [JWT Introduction](https://jwt.io/introduction)

## License

MIT License - see [LICENSE](../../LICENSE) for details.
