# subscan.sh

`subscan.sh` is a Bash script designed for discovering **subdomains**, checking their **status** (live or not), and identifying **restrictions** like access control or firewalls. It is primarily aimed at helping security researchers and system administrators find vulnerable or restricted subdomains.

## Features
- **Subdomain Discovery**: Automatically discovers subdomains using predefined sources.
- **Subdomain Status**: Checks whether subdomains are live (responsive) or not.
- **Restriction Check**: Identifies potential restrictions on subdomains, such as firewalls or access control.
- **Command-Line Interface**: Simple and easy-to-use with a few command-line arguments.
- **Logs Results**: Outputs results to a log file, categorizing subdomains as **live**, **down**, or **restricted**.

## Installation

To use `subscan.sh`, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/p4p2/subscan.sh.git
   cd subscan.sh
