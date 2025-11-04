# Templates Overview

ShruggieTech Dev Handbook provides ready-to-use project templates to accelerate development. Each template includes complete project structure, configuration files, sample code, and documentation.

## Available Templates

### 🟢 Node.js API Template
RESTful API built with Node.js and Express.

**Best For**: Web APIs, microservices, backend services  
**Tech Stack**: Node.js, Express, TypeScript (optional)  
**Download**: [nodejs-api.zip](https://github.com/shruggietech/dev-handbook/tree/main/templates/nodejs-api)

[View Documentation](nodejs-api.md)

### 🐍 Python CLI Template
Command-line application with Click framework.

**Best For**: CLI tools, automation scripts, utilities  
**Tech Stack**: Python, Click, Rich  
**Download**: [python-cli.zip](https://github.com/shruggietech/dev-handbook/tree/main/templates/python-cli)

[View Documentation](python-cli.md)

### 🌐 Static Website Template
Modern static website with responsive design.

**Best For**: Landing pages, documentation sites, portfolios  
**Tech Stack**: HTML5, CSS3, JavaScript  
**Download**: [static-website.zip](https://github.com/shruggietech/dev-handbook/tree/main/templates/static-website)

[View Documentation](static-website.md)

## How to Use Templates

### Method 1: Download from GitHub

1. Navigate to the template folder in the repository
2. Click the "Download" button or use Git:

```bash
# Clone the entire repository
git clone https://github.com/shruggietech/dev-handbook.git

# Copy the template you need
cp -r dev-handbook/templates/nodejs-api my-new-project
cd my-new-project
```

### Method 2: Download as ZIP

Download individual templates as ZIP files:

```bash
# Using curl (replace TEMPLATE_NAME)
curl -L https://github.com/shruggietech/dev-handbook/archive/main.zip -o handbook.zip
unzip handbook.zip
cp -r dev-handbook-main/templates/TEMPLATE_NAME my-project
```

### Method 3: Use GitHub CLI

```bash
# Install GitHub CLI if not already installed
gh repo clone shruggietech/dev-handbook

# Copy template
cp -r dev-handbook/templates/nodejs-api my-new-project
```

## Template Structure

All templates follow a consistent structure:

```
template-name/
├── README.md              # Setup and usage instructions
├── .gitignore            # Git ignore patterns
├── src/                  # Source code
├── tests/                # Test files
├── docs/                 # Additional documentation
├── config/               # Configuration files
└── package.json/         # Dependencies (language-specific)
    pyproject.toml
    requirements.txt
```

## After Downloading

### 1. Customize the Template

```bash
cd my-new-project

# Update project name in package.json/pyproject.toml
# Update README.md with your project details
# Update LICENSE if needed
```

### 2. Install Dependencies

**Node.js**:
```bash
npm install
```

**Python**:
```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Initialize Git

```bash
git init
git add .
git commit -m "Initial commit from ShruggieTech template"
```

### 4. Start Development

Follow the template-specific README for:
- Running development servers
- Building for production
- Running tests
- Deployment instructions

## Template Comparison

| Template | Language | Complexity | Setup Time | Best For |
|----------|----------|------------|------------|----------|
| Node.js API | JavaScript/TypeScript | Medium | 5 min | REST APIs, Backends |
| Python CLI | Python | Low | 3 min | CLI Tools, Scripts |
| Static Website | HTML/CSS/JS | Low | 2 min | Websites, Landing Pages |

## Customization Tips

### Update Project Metadata

**Node.js** (`package.json`):
```json
{
  "name": "your-project-name",
  "version": "1.0.0",
  "description": "Your project description",
  "author": "Your Name"
}
```

**Python** (`pyproject.toml`):
```toml
[project]
name = "your-project-name"
version = "1.0.0"
description = "Your project description"
authors = [{name = "Your Name", email = "you@example.com"}]
```

### Configure Development Tools

Templates include pre-configured:
- Linters (ESLint, Pylint)
- Formatters (Prettier, Black)
- Testing frameworks (Jest, pytest)
- CI/CD workflows (GitHub Actions)

Adjust these in their respective config files.

### Add Environment Variables

Create `.env` file (never commit this!):

```bash
# .env
API_KEY=your-api-key
DATABASE_URL=postgresql://localhost/mydb
DEBUG=true
```

Load in your application:
- **Node.js**: `dotenv` package
- **Python**: `python-dotenv` package

## Template Maintenance

Templates are regularly updated with:
- Security patches
- Dependency updates
- Best practice improvements
- New features

Check the repository for updates:

```bash
cd dev-handbook
git pull origin main
```

## Contributing Templates

Want to add a new template? We welcome contributions!

### Requirements

1. **Complete Project**: Fully functional starter project
2. **Documentation**: Comprehensive README
3. **Best Practices**: Follow language conventions
4. **Dependencies**: Use stable, maintained packages
5. **Testing**: Include test examples
6. **CI/CD**: Include GitHub Actions workflow

### Submission Process

1. Fork the repository
2. Create template in `/templates/your-template-name/`
3. Add documentation in `/docs/templates/your-template-name.md`
4. Update this README
5. Submit pull request

See [Contributing Guidelines](../contributing.md) for details.

## Template Requests

Need a template that doesn't exist? 

- Open an issue on GitHub
- Describe the use case
- Specify technology stack
- Explain why it would be useful

We'll consider adding it to the collection!

## Support

For template-specific questions:
- Check the template's README
- Review the documentation page
- Search existing issues
- Create a new issue with the `template` label

## License

All templates are provided under the MIT License. You're free to:
- Use commercially
- Modify as needed
- Distribute
- Sublicense

See [LICENSE](https://github.com/shruggietech/dev-handbook/blob/main/LICENSE) for full details.
