
---

# nuclei-installer
An Automated Script to Install Nuclei and Other Project Discovery Tools

---

## Installation Script for Security Tools

This script automates the installation and verification of several security tools, including Project Discovery tools, Python libraries, and Findomain. It ensures that all necessary dependencies are met and that the tools are correctly installed and configured.

## Table of Contents
- [Features](#features)
- [Tools Installed](#tools-installed)
- [Prerequisites](#prerequisites)
- [Installation Guide](#installation-guide)
- [Usage](#usage)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features
- **Automated Installation**: Installs essential security tools like Nuclei, HTTPX, Subfinder, Amass, Naabu, and Findomain.
- **Go Version Management**: Checks and updates Go to version 1.21 or later to ensure compatibility with the latest tools.
- **Python Environment Setup**: Installs and updates Python libraries, including `requests` and `beautifulsoup4`.
- **Verification**: Ensures all tools are installed and functional, providing version checks and updates for Nuclei templates.

## Tools Installed
- [Nuclei](https://github.com/projectdiscovery/nuclei): A fast and customizable vulnerability scanner based on YAML templates.
- [HTTPX](https://github.com/projectdiscovery/httpx): A fast, multi-purpose HTTP toolkit that allows running multiple probes using a retryable HTTP client.
- [Subfinder](https://github.com/projectdiscovery/subfinder): A subdomain discovery tool that finds valid subdomains for websites.
- [Amass](https://github.com/OWASP/Amass): An in-depth attack surface mapping and asset discovery tool.
- [Naabu](https://github.com/projectdiscovery/naabu): A fast port scanner for scanning open ports on targets.
- [Findomain](https://github.com/findomain/findomain): A tool for discovering subdomains using multiple sources for high efficiency.
- **Python Libraries**: `requests`, `beautifulsoup4`

## Prerequisites
- **Operating System**: The script is designed to run on Debian-based systems, such as Ubuntu or Kali Linux.
- **User Privileges**: The script requires `sudo` access to install packages and move binaries.

## Installation Guide
### Step 1: Clone the Repository
Clone the repository containing the script:
```bash
git clone https://github.com/xenigmus/nuclei-installer
cd nuclei-installer
```

### Step 2: Make the Script Executable
Make the script executable:
```bash
chmod +x install_tools.sh
```

### Step 3: Run the Script
Run the installation script:
```bash
./install_tools.sh
```

This script will:
1. Update package lists and install essential packages.
2. Install and verify Go (version 1.21 or later).
3. Install the security tools provided by [Project Discovery](https://projectdiscovery.io/).
4. Install Nuclei and update its templates to the latest version.
5. Install Python libraries for additional functionality.
6. Install and set up Findomain.
7. Verify that all tools are installed and functional.

## Usage
After installation, you can use the installed tools directly from the terminal. Examples:
- Run Nuclei:
  ```bash
  nuclei -h
  ```
- Run Subfinder:
  ```bash
  subfinder -d example.com
  ```

## Verification
The script includes a verification step that checks:
1. The installation and version of Go.
2. The installation and version of each security tool.
3. The successful installation and update of Nuclei templates.
4. The installation and version of required Python libraries.

If any tool is missing, the script attempts to reinstall it.

## Troubleshooting
- **Go Not Found or Outdated**: The script checks for Go installation and updates it if the version is below 1.21. Ensure that the Go binary is in your PATH.
- **Permission Issues**: Ensure you run the script with `sudo` privileges.
- **Nuclei Templates Update Fails**: If the template update fails, the script will retry. Ensure that your internet connection is stable.

## Contributing
Contributions are welcome! Please fork this repository, create a new branch, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the GNU General Public License v3.0. You can view the license details in the [LICENSE](LICENSE) file or visit [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html) for more information.

---