# Setup Guide

This guide will walk you through setting up your development environment to use the ShruggieTech Dev Handbook resources.

## 1. Clone the Repository

First, clone the dev-handbook repository to your local machine:

```bash
git clone https://github.com/shruggietech/dev-handbook.git
cd dev-handbook
```

## 2. Explore the Repository Structure

Familiarize yourself with the repository layout:

```
dev-handbook/
├── docs/              # Documentation (what you're reading now)
├── scripts/           # Automation scripts
│   ├── powershell/    # Windows PowerShell scripts
│   ├── bash/          # Linux/macOS shell scripts
│   └── python/        # Cross-platform Python utilities
├── templates/         # Starter project templates
├── index.html         # Docsify homepage
└── README.md          # Project overview
```

## 3. Browse Documentation Locally

You can view the documentation locally using Docsify:

### Option 1: Using Python (Quick)
```bash
cd dev-handbook
python -m http.server 3000
```

Then open http://localhost:3000 in your browser.

### Option 2: Using Docsify CLI (Recommended)
```bash
# Install Docsify CLI globally
npm install -g docsify-cli

# Serve the docs
docsify serve .
```

Then open http://localhost:3000 in your browser.

### Option 3: Using Live Server (VS Code)
If using Visual Studio Code:
1. Install the "Live Server" extension
2. Right-click on `index.html`
3. Select "Open with Live Server"

## 4. Using Scripts

### PowerShell Scripts

**Windows**:
```powershell
cd scripts/powershell
.\script-name.ps1
```

**macOS/Linux** (with PowerShell Core):
```bash
cd scripts/powershell
pwsh ./script-name.ps1
```

### Bash Scripts

Make scripts executable and run them:
```bash
cd scripts/bash
chmod +x script-name.sh
./script-name.sh
```

### Python Scripts

Install dependencies and run scripts:
```bash
cd scripts/python
pip install -r requirements.txt  # if dependencies exist
python script-name.py
```

## 5. Using Templates

### Download a Template

Templates can be downloaded as ZIP files from GitHub:

1. Navigate to the `/templates` directory in the repository
2. Select the template you want
3. Download the folder or use the download script (coming soon)

### Extract and Use

```bash
# Example: Using the Node.js API template
cd templates/nodejs-api
npm install
npm run dev
```

Each template includes its own README with specific setup instructions.

## 6. Contributing Back

If you make improvements or create new scripts/templates:

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
# ...

# Commit and push
git add .
git commit -m "Add: your feature description"
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## 7. Stay Updated

Keep your local copy up to date:

```bash
git pull origin main
```

## Environment Variables (Optional)

Some scripts may require environment variables. Create a `.env` file in the script directory:

```bash
# Example .env file
API_KEY=your-api-key-here
DATABASE_URL=your-database-url
```

⚠️ **Never commit `.env` files to version control!**

## Troubleshooting

### Permission Issues (Linux/macOS)
If you encounter permission errors with scripts:
```bash
chmod +x script-name.sh
```

### PowerShell Execution Policy (Windows)
If PowerShell blocks script execution:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### Python Module Not Found
Install missing Python packages:
```bash
pip install module-name
```

## Next Steps

Now that your environment is set up, explore:
- [Scripts Overview](../scripts/overview.md) - Available automation tools
- [Templates Overview](../templates/README.md) - Project starter kits
- [Best Practices](../best-practices/code-standards.md) - Development guidelines
