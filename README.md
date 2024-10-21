# Ubuntu Scripts

This repository contains scripts I wrote to automate the setup and maintenance of my Ubuntu System. It includes two main scripts: one for initial installation and configuration of essential tools and applications, and another for routine system updates.

## Scripts

### 1. `install.sh`

The `install.sh` script automates the following tasks:

- Updates and upgrades the system.
- Installs essential packages and development tools.
- Configures Git with user-defined credentials.
- Installs various programming fonts.
- Sets up commonly used applications such as [Bitwarden](https://bitwarden.com/), [KeepassXC](https://keepassxc.org/), and [LocalSend](https://localsend.org/).
- Installs Node.js and NPM using Node Version Manager (nvm).
- Creates an `update.sh` script for future system maintenance.

### 2. `update.sh`

The `update.sh` script provides a simple way to keep your system up to date. It performs the following tasks:

- Updates package lists.
- Upgrades installed packages.
- Cleans up unnecessary packages (optional).
- Updates Snap and Flatpak packages.

## Prerequisites

- A Debian-based Linux distribution (e.g., Ubuntu).
- `sudo` privileges to install packages and make system changes.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Make the Scripts Executable**:
   ```bash
   chmod +x install.sh
   chmod +x update.sh
   ```

3. **Run the Installation Script**:
   ```bash
   ./install.sh
   ```

4. **Follow the Prompts**: The installation script will guide you through the process. Customize the Git configuration with your details.

5. **Run the Update Script**: To keep your system updated in the future, run:
   ```bash
   ./update.sh
   ```

## Configuration

- **Git Configuration**: In the `install.sh` script, update the following lines with your Git username and email:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```

## Notes

- After running the `install.sh` script, you may need to restart your terminal or source your shell configuration file to make Node.js available.
- The cleanup commands in `update.sh` are commented out by default. Uncomment them if you wish to enable cleanup functionality.
- This scripts were tested on Ubuntu 24.04
