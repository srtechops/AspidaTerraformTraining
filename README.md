# 🚀 Installing Terraform on Windows

Follow this guide to install and set up Terraform on your Windows machine.

---

## ✅ Step 1: Download Terraform

1. Visit the official Terraform website: [Terraform Downloads](https://www.terraform.io/downloads.html).
2. Select **Windows** as your operating system.
3. Choose the appropriate version (typically **amd64** for most users).
4. Click **Download** and save the `.zip` file to your computer.

> 📥 Once the download completes, continue to the next step.

---

## 📦 Step 2: Extract the Terraform Files

1. Locate the downloaded `.zip` file.
2. Use a tool like **WinRAR**, **7-Zip**, or the built-in **Windows Extractor** to extract the contents.
3. You will find a single file: `terraform.exe`.

> 💡 Tip: Create a dedicated folder such as `C:\terraform` and move `terraform.exe` there for easier management.

---

## ⚙️ Step 3: Add Terraform to the System Path

To run Terraform from any command prompt, add it to your system’s `Path` environment variable:

1. Open the **Start Menu** and search for **Environment Variables**.
2. Click on **Edit the system environment variables**.
3. In the **System Properties** window, click **Environment Variables**.
4. Under **System Variables**, scroll down and select the `Path` variable, then click **Edit**.
5. Click **New** and enter the folder path where `terraform.exe` is located (e.g., `C:\terraform`).
6. Click **OK** to save your changes.

> 🧑‍💻 Terraform is now accessible from any terminal window.

---

## 🧪 Step 4: Verify Installation

1. Open **Command Prompt** or **PowerShell**.
2. Run the following command:

   ```sh
   terraform version
