# Node.js API Template

A production-ready RESTful API template built with Node.js and Express.

## Features

- Express.js web framework
- RESTful API structure
- Environment configuration
- Error handling middleware
- Request validation
- API documentation ready
- Example endpoints

## Quick Start

### Prerequisites

- Node.js 18+ and npm

### Installation

```bash
# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Edit .env with your configuration
```

### Development

```bash
# Start development server
npm run dev

# Server will run on http://localhost:3000
```

## Project Structure

```
nodejs-api/
├── src/
│   ├── routes/          # API routes
│   ├── controllers/     # Route controllers
│   ├── middleware/      # Custom middleware
│   ├── models/          # Data models
│   └── app.js           # Express app setup
├── .env.example         # Environment variables template
├── .gitignore
├── package.json
└── README.md
```

## API Endpoints

### Health Check
```
GET /api/health
```

Returns server status.

### Example User Endpoints
```
GET    /api/users       # Get all users
GET    /api/users/:id   # Get user by ID
POST   /api/users       # Create new user
PUT    /api/users/:id   # Update user
DELETE /api/users/:id   # Delete user
```

## Configuration

Edit `.env` file:

```env
NODE_ENV=development
PORT=3000
API_VERSION=v1
```

## Testing

```bash
# Run tests
npm test

# Run with coverage
npm run test:coverage
```

## Building for Production

```bash
# Start production server
npm start
```

## License

MIT License - see [LICENSE](../../LICENSE) for details.
