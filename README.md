# AI-Assisted Article Data Extraction

A Python-based project for extracting structured data from scientific articles (PDFs) using AI (Mistral) and generating Excel output files. The project automates the conversion of PDFs to text, extracts predefined variables, and tracks progress for resumable operations.

---

## 📌 **Features**

- **PDF to Text Conversion**: Converts PDF articles to plain text for processing.
- **AI-Powered Extraction**: Uses Mistral AI to extract predefined variables from article text.
- **Structured Output**: Generates Excel files (`output.xlsx` and `validation.xlsx`) with extracted data.
- **Progress Tracking**: Uses a control file (`control_file.csv`) to track processed articles and resume interrupted operations.
- **Progress Bars**: Visual feedback for monitoring the extraction process.
- **Validation**: Tracks the source line in the text file for each extracted piece of data.

---

## 📂 **Project Structure**

```
.
├── LLM_instructions.txt          # Project instructions and scope
├── extraction.ipynb              # Jupyter Notebook for extraction
├── improved_extraction.ipynb     # Improved version of the extraction notebook
├── control_file.csv              # Tracks processed/unprocessed articles
├── output.xlsx                   # Extracted data in Excel format
├── validation.xlsx               # Validation data with source lines
├── requirements.txt              # Python dependencies
├── install_cli_tools.sh          # Script to install CLI tools (Linux/Mac)
├── SYSTEM_DEPENDENCIES.md        # Manual installation instructions for CLI tools
├── guide_docs/                   # Reference documents
│   ├── TRS_data_extraction_template.xlsx      # Template for output structure
│   └── TRS_lista_de_variaveis_e_descricoes.xlsx # List of variables and descriptions
├── pdfs_extracted/               # Folder for extracted text files
│   └── Capogrosso2013            # Example: Extracted text file
└── pdfs_to_extract/              # Folder for PDFs to process
    └── Capogrosso2013.pdf        # Example: PDF to extract
```

---

## 🛠 **Setup & Installation**

### **Prerequisites**
- Python 3.8+
- Git
- `pdftotext` (from Poppler) for PDF to text conversion

### **Installation**

1. **Clone the Repository**
   ```bash
   git clone <repository_url>
   cd <repository_folder>
   ```

2. **Create a Virtual Environment (Recommended)**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # Linux/Mac
   .\.venv\Scripts\activate   # Windows
   ```

3. **Install Python Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Install System-Level Dependencies**
   This project requires CLI tools like `pdftotext` (from Poppler).
   
   - **Linux/Mac**: Run the following script to automate the installation:
     ```bash
     chmod +x install_cli_tools.sh
     ./install_cli_tools.sh
     ```
   - **Windows**: See **[SYSTEM_DEPENDENCIES.md](SYSTEM_DEPENDENCIES.md)** for manual installation instructions.
   
   For more details, refer to **[SYSTEM_DEPENDENCIES.md](SYSTEM_DEPENDENCIES.md)**.

5. **Set Up Mistral API Key**
   - Create a `.env` file in the root directory:
     ```plaintext
     MISTRAL_API_KEY=your_api_key_here
     ```
   - Replace `your_api_key_here` with your actual Mistral API key.

---

## 🚀 **Usage**

### **1. Add PDFs to Process**
Place all PDF files you want to process into the `pdfs_to_extract/` folder.

### **2. Update the Control File**
The `control_file.csv` tracks the status of each article:
- `article`: Name of the PDF file (without extension).
- `status`: `done` (processed) or `pending` (not processed).

Example:
```csv
article,status
Capogrosso2013,done
NewArticle2024,pending
```

### **3. Run the Extraction**

#### **Option 1: Using Jupyter Notebook**
1. Open `extraction.ipynb` or `improved_extraction.ipynb` in Jupyter Notebook/Lab:
   ```bash
   jupyter notebook
   ```
2. Follow the instructions in the notebook to run the extraction process.

#### **Option 2: Using Python Script**
1. Convert the notebook to a Python script (if needed):
   ```bash
   jupyter nbconvert --to script extraction.ipynb
   ```
2. Run the script:
   ```bash
   python extraction.py
   ```

### **4. Output Files**
- **`output.xlsx`**: Contains extracted data in the format defined by `TRS_data_extraction_template.xlsx`.
  - Tabs: `STUDY`, `GROUP`, `OUTCOMES`, etc.
- **`validation.xlsx`**: Contains validation data, including the line numbers from the text file where each piece of information was found.

---

## 📝 **Key Variables & Templates**

### **Variable Descriptions**
The variables to extract are defined in `guide_docs/TRS_lista_de_variaveis_e_descricoes.xlsx`. Each variable has a description to guide the extraction process.

### **Output Template**
The output follows the structure of `guide_docs/TRS_data_extraction_template.xlsx`:
- **STUDY**: Study-level variables (e.g., title, authors, year).
- **GROUP**: Group-level variables (e.g., intervention, control).
- **OUTCOMES**: Outcome measures and results.

---

## 🔍 **How It Works**

1. **PDF to Text Conversion**
   - PDFs in `pdfs_to_extract/` are converted to text files and saved in `pdfs_extracted/`.
   - Uses `pdftotext` with the `-layout` option to preserve formatting.

2. **AI Extraction**
   - The text file is processed using Mistral AI to extract predefined variables.
   - The AI is prompted to find specific information based on the variable descriptions.

3. **Data Validation**
   - For each extracted variable, the line number in the text file is recorded in `validation.xlsx`.
   - If a variable is not found, it is marked as `NFAS` (Not Found by Automated Search).

4. **Progress Tracking**
   - The `control_file.csv` is updated as articles are processed.
   - If the process is interrupted, it can be resumed by checking the control file.

---

## 📊 **Example Workflow**

1. Add `NewStudy2024.pdf` to `pdfs_to_extract/`.
2. Update `control_file.csv`:
   ```csv
   article,status
   Capogrosso2013,done
   NewStudy2024,pending
   ```
3. Run the extraction script.
4. The script:
   - Converts `NewStudy2024.pdf` to `pdfs_extracted/NewStudy2024`.
   - Extracts variables using Mistral AI.
   - Updates `output.xlsx` and `validation.xlsx`.
   - Marks `NewStudy2024` as `done` in `control_file.csv`.

---

## 🛠 **Customization**

### **Adding New Variables**
1. Update `TRS_lista_de_variaveis_e_descricoes.xlsx` with new variables and descriptions.
2. Update `TRS_data_extraction_template.xlsx` to include the new variables in the appropriate tabs.

### **Modifying the AI Prompt**
Edit the prompt in `extraction.ipynb` or `improved_extraction.ipynb` to change how the AI extracts data. Example:
```python
prompt = f"""
Extract the following variables from the text below:
{variables_to_extract}

Text:
{text_content}

Return the results as a JSON object with the variable names as keys.
If a variable is not found, use 'NFAS' as the value.
"""
```

---

## 🐛 **Troubleshooting**

| Issue | Solution |
|-------|----------|
| `pdftotext` not found | Install `poppler-utils` (Linux) or `poppler` (Mac). See **[SYSTEM_DEPENDENCIES.md](SYSTEM_DEPENDENCIES.md)** for details. |
| Mistral API errors | Check your API key and network connection. |
| Missing Python dependencies | Run `pip install -r requirements.txt`. |
| PDF conversion fails | Ensure the PDF is not corrupted or password-protected. |
| AI extraction returns `NFAS` | Verify the variable descriptions and text content. |
| Permission denied for CLI tools | Ensure the tools are installed correctly and your user has execution permissions. |

---

## 📜 **License**

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 🤝 **Contributing**

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

---

## 📧 **Contact**

For questions or support, contact the project maintainer:
- **Name**: Paulo Cabral
- **Email**: paulocabral@example.com (replace with actual email)

---

## 📚 **Acknowledgments**

- [Mistral AI](https://mistral.ai/) for providing the AI model.
- [Poppler](https://poppler.freedesktop.org/) for PDF to text conversion.
- [Pandas](https://pandas.pydata.org/) for data handling.