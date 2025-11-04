# ShruggieTech Dev Handbook

Welcome to the ShruggieTech Dev Handbook - your comprehensive resource for development workflows, automation scripts, and starter templates.

## 📚 What's Inside

This handbook provides:

- **Documentation** - Wiki-style guides and best practices under `/docs`
- **Automation Scripts** - PowerShell, Bash, and Python utilities under `/scripts`
- **Starter Templates** - Ready-to-use project templates under `/templates`
- **Interactive Docs** - Browse documentation via Docsify at GitHub Pages

## 🚀 Quick Start

### Browse the Documentation

Visit the live documentation site:
**https://shruggietech.github.io/dev-handbook/**

Or run locally:

```bash
# Using Python
python -m http.server 3000

# Using Docsify CLI
npm install -g docsify-cli
docsify serve .

# Then open http://localhost:3000
```

### Use the Scripts

Scripts are organized by platform:

```bash
# PowerShell (Windows/Cross-platform)
cd scripts/powershell
.\get-system-info.ps1

# Bash (Linux/macOS)
cd scripts/bash
chmod +x system-info.sh
./system-info.sh

# Python (Cross-platform)
cd scripts/python
pip install -r requirements.txt
python system_info.py
```

### Use the Templates

Download and customize starter templates:

```bash
# Clone the repository
git clone https://github.com/shruggietech/dev-handbook.git

# Copy a template
cp -r dev-handbook/templates/nodejs-api my-new-project
cd my-new-project

# Follow the template's README for setup
```

## 📁 Repository Structure

```
dev-handbook/
├── docs/                      # Documentation
│   ├── getting-started/       # Setup guides
│   ├── scripts/               # Script documentation
│   ├── templates/             # Template documentation
│   └── best-practices/        # Development guidelines
├── scripts/                   # Automation scripts
│   ├── powershell/            # Windows PowerShell scripts
│   ├── bash/                  # Linux/macOS shell scripts
│   └── python/                # Cross-platform Python utilities
├── templates/                 # Starter project templates
│   ├── nodejs-api/            # Node.js API template
│   ├── python-cli/            # Python CLI template
│   └── static-website/        # Static website template
├── index.html                 # Docsify homepage
├── .nojekyll                  # GitHub Pages configuration
└── README.md                  # This file
```

## 📖 Documentation Sections

- **[Getting Started](docs/getting-started/overview.md)** - Prerequisites and setup
- **[Scripts](docs/scripts/overview.md)** - Automation utilities reference
- **[Templates](docs/templates/README.md)** - Project starter kits
- **[Best Practices](docs/best-practices/code-standards.md)** - Development guidelines

## 🛠️ Available Scripts

### PowerShell Scripts
- `get-system-info.ps1` - Display comprehensive system information
- And more...

### Bash Scripts
- `system-info.sh` - Cross-platform system information
- And more...

### Python Scripts
- `system_info.py` - Detailed system information collector
- And more...

See the [Scripts Overview](docs/scripts/overview.md) for complete documentation.

## 📦 Available Templates

### Node.js API
RESTful API built with Node.js and Express.
[View Template](templates/nodejs-api/) | [Documentation](docs/templates/nodejs-api.md)

### Python CLI
Command-line application with Click framework.
[View Template](templates/python-cli/) | [Documentation](docs/templates/python-cli.md)

### Static Website
Modern responsive website with HTML/CSS/JS.
[View Template](templates/static-website/) | [Documentation](docs/templates/static-website.md)

## 🤝 Contributing

Contributions are welcome! Please see our [Contributing Guidelines](docs/contributing.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

- [Live Documentation](https://shruggietech.github.io/dev-handbook/)
- [GitHub Repository](https://github.com/shruggietech/dev-handbook)
- [Issue Tracker](https://github.com/shruggietech/dev-handbook/issues)
- [Discussions](https://github.com/shruggietech/dev-handbook/discussions)

## ⭐ Acknowledgments

Built with:
- [Docsify](https://docsify.js.org/) - Documentation site generator
- [GitHub Pages](https://pages.github.com/) - Hosting
- Community contributions

---

**Made with ❤️ by ShruggieTech**
