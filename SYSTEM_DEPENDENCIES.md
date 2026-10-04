# System-Level Dependencies

This file lists the CLI tools and system-level dependencies required for the **AI-Assisted Article Data Extraction** project. These are not Python packages and must be installed separately on your system.

---

## 🚀 **Quick Installation**

For **Linux (Debian/Ubuntu)** and **Mac (Homebrew)**, you can use the provided script to automate the installation of all required CLI tools:

```bash
chmod +x install_cli_tools.sh
./install_cli_tools.sh
```

For **Windows** or other systems, follow the manual installation instructions below.

---

## 📌 **Required CLI Tools**

### 1. **`pdftotext` (Poppler)**
   - **Purpose**: Converts PDF files to plain text format.
   - **Installation**:
     - **Linux (Debian/Ubuntu)**:
       ```bash
       sudo apt-get update
       sudo apt-get install poppler-utils
       ```
     - **Mac (Homebrew)**:
       ```bash
       brew install poppler
       ```
     - **Windows**:
       - Download the Poppler for Windows from [poppler.freedesktop.org](https://poppler.freedesktop.org/).
       - Add the `bin` folder to your system's `PATH` environment variable.
       - Alternatively, use Chocolatey:
         ```bash
         choco install poppler
         ```
   - **Verification**:
     Run the following command to check if `pdftotext` is installed:
     ```bash
     pdftotext -v
     ```

---

## 🔍 **Optional CLI Tools**

### 1. **`git`**
   - **Purpose**: Version control for cloning and managing the repository.
   - **Installation**:
     - **Linux (Debian/Ubuntu)**:
       ```bash
       sudo apt-get install git
       ```
     - **Mac (Homebrew)**:
       ```bash
       brew install git
       ```
     - **Windows**:
       Download from [git-scm.com](https://git-scm.com/).

### 2. **`jupyter`**
   - **Purpose**: Running Jupyter Notebooks for interactive development.
   - **Installation**:
     Install via `pip` (already included in `requirements.txt`):
     ```bash
     pip install jupyter
     ```

---

## 🛠 **Troubleshooting**

### **`pdftotext` Not Found**
- **Error**: `pdftotext: command not found`
- **Solution**:
  - Ensure Poppler is installed (see above).
  - On Windows, verify that the Poppler `bin` folder is added to your `PATH`.
  - Restart your terminal or IDE after installation.

### **Permission Issues**
- **Error**: Permission denied when running `pdftotext`.
- **Solution**:
  - On Linux/Mac, ensure the user has execution permissions:
    ```bash
    chmod +x /usr/bin/pdftotext
    ```
  - On Windows, run the terminal as Administrator.

---

## 📝 **Notes**

- These dependencies are **system-level** and must be installed globally or in your user environment.
- They are **not** managed by `pip` or `requirements.txt`.
- If you're using a virtual environment, these tools must still be installed at the system level.