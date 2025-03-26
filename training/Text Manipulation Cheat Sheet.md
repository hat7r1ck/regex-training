# Text Manipulation Cheat Sheet

This cheat sheet is designed for Windows users working in Notepad++ or VS Code. It covers common text manipulation tasks—from reformatting data to using regex—helpful during cybersecurity investigations.

---

## 1. Basic Find & Replace Essentials

### Inserting New Lines
- **Scenario:** Convert a long string (e.g., comma-separated values) into multiple lines.
  
**Notepad++:**
- Open **Replace** (Ctrl+H).
- **Search Mode:** Select **Extended (\n, \r, \t, \0)**.
- **Find what:** For example, a comma `,`
- **Replace with:** `\r\n` *(Windows new lines)*
- Click **Replace All**.

**VS Code:**
- Open **Find and Replace** (Ctrl+H).
- Enable **Regex mode** by clicking the `.*` icon (if needed).
- **Find:** Your delimiter (e.g., `,`)
- **Replace:** `\n`
- Click **Replace All**.

### Removing Trailing Whitespace
- **Purpose:** Clean up extra spaces at the end of lines.

**Both Editors (Regex Mode):**
- **Find:** `\s+$`
- **Replace:** *(Leave blank)*
- Click **Replace All**.

---

## 2. Adding or Modifying Text

### Adding a Prefix (e.g., "hostname=")
- **Scenario:** You have a list of hostnames (one per line) and need to add a prefix.

**Notepad++:**
- Open **Replace** (Ctrl+H).
- **Search Mode:** Select **Regular Expression**.
- **Find:** `^` *(matches the start of each line)*
- **Replace:** `hostname=`
- Click **Replace All**.

**VS Code:**
- Open **Find and Replace** (Ctrl+H).
- Enable **Regex mode** (click the `.*` icon).
- **Find:** `^`
- **Replace:** `hostname=`
- Click **Replace All**.

### Adding a Suffix (e.g., appending “.local”)
- **Scenario:** Append a suffix to each line.

**Both Editors (Regex Mode):**
- **Find:** `$` *(matches the end of each line)*
- **Replace:** `.local`
- Click **Replace All**.

---

## 3. Changing Text Case

### Convert to Uppercase or Lowercase
**Notepad++:**
- **Uppercase:** Select text → **Edit → Convert Case to → UPPERCASE**.
- **Lowercase:** Select text → **Edit → Convert Case to → lowercase**.

**VS Code:**
- Select text.
- Open the **Command Palette** (Ctrl+Shift+P) and type:
  - `Transform to Uppercase` or  
  - `Transform to Lowercase`.

### Swap Case
- **Notepad++:** Some versions offer **Edit → Convert Case to → Swap Case**.
- **VS Code:** May require an extension (search for “Swap Case”) if not available by default.

---

## 4. Additional Text Manipulation Tips

### Removing Extra Spaces
- **Goal:** Convert multiple spaces into a single space.

**Both Editors (Regex Mode):**
- **Find:** `[ ]{2,}` or `\s+`
- **Replace:** A single space (` `)
- Click **Replace All**.

### Multi-Cursor / Column Editing
- **Notepad++:**
  - Hold **Alt** and drag the mouse to select a block, or use **Alt+Shift+Arrow Keys**.
- **VS Code:**
  - Hold **Alt** and click where you need additional cursors.
  - Or use **Ctrl+Alt+Down/Up Arrow** to add cursors vertically.

### Sorting Lines and Removing Duplicates
**Notepad++:**
- **Sort Lines:** **Edit → Line Operations → Sort Lines Lexicographically**.
- **Remove Duplicate Lines:** Use **TextFX → TextFX Tools → Remove Duplicate Lines** *(if TextFX is installed)*.

**VS Code:**
- Sorting may require an extension or using a multi-step process (e.g., copy lines into Excel, sort, then paste back).

---

## 5. Practical Examples for Cybersecurity Investigations

### Formatting Log Data into Readable Entries
- **Example:** Convert a comma-separated string of IP addresses into individual lines.
  - **Notepad++:** Replace commas (`,`) with `\r\n` in Extended mode.
  - **VS Code:** Replace commas with `\n` in Regex mode.

### Adding Context to Data Entries
- **Example:** Prefix each hostname in a list with “hostname=”.
  - Follow the instructions in Section 2 to add the prefix using regex (`^` → `hostname=`).

### Converting Data for Uniformity
- **Example:** Changing all hostnames to lowercase.
  - Use the **Convert to Lowercase** function after selecting the text.

---

## 6. Processing a Space-Separated List of Hostnames

**Scenario:** You have a line with multiple hostnames (e.g., `host1 host2 host-3 another-host`) and want to reformat it into:
hostname=host1
hostname=host2
hostname=host-3
hostname=another-host

### **Method 1: Two-Step Approach**

1. **Split the Hosts into Separate Lines**

   **Notepad++:**
   - Open **Replace** (Ctrl+H).
   - **Search Mode:** Select **Extended (\n, \r, \t, \0)**.
   - **Find what:** A single space ` `
   - **Replace with:** `\r\n`
   - Click **Replace All**.

   **VS Code:**
   - Open **Find and Replace** (Ctrl+H).
   - **Find:** A space ` `
   - **Replace:** `\n`
   - Click **Replace All**.

2. **Add the Prefix to Each Line**

   **Both Editors (Regex Mode):**
   - **Find:** `^`
   - **Replace:** `hostname=`
   - Click **Replace All**.

### **Method 2: One-Step Regex Approach**

**Notepad++ / VS Code:**
- Open **Replace** and enable **Regex mode**.
- **Find:** `(\S+)`  
  *(Matches any group of non-space characters)*
- **Replace:** `hostname=$1\r\n`  
  - *(For VS Code, use `\n` for a newline.)*
- Click **Replace All**.  
  *(Note: This might add an extra newline at the end, which can be removed manually.)*

---

## 7. Regex Shorthand Reference

| Regex     | Meaning                                                           | Example                                           |
|-----------|-------------------------------------------------------------------|---------------------------------------------------|
| `\S`      | Matches any non-whitespace character                              | `\S+` matches one or more non-space characters     |
| `\s`      | Matches any whitespace character (space, tab, newline)            | `\s+` matches one or more whitespace characters    |
| `\d`      | Matches any digit (0-9)                                             | `\d{3}` matches exactly three digits              |
| `\w`      | Matches any word character (letters, digits, underscore)            | `\w+` matches one or more word characters           |
| `.`       | Matches any character except a newline                            | `a.b` matches "a_b", "a b", etc.                    |
| `+`       | One or more of the preceding element                              | `a+` matches "a", "aa", "aaa", etc.                 |
| `*`       | Zero or more of the preceding element                             | `a*` matches "", "a", "aa", etc.                    |
| `?`       | Zero or one of the preceding element; also for non-greedy matching    | `a?` matches "" or "a"                             |
| `^`       | Matches the start of a line                                         | `^hostname=` matches lines beginning with "hostname="|
| `$`       | Matches the end of a line                                           | `\.local$` matches lines ending with ".local"       |
| `[...]`   | Character set: matches any one character inside the brackets         | `[abc]` matches "a", "b", or "c"                    |
| `( ... )` | Capturing group: captures the matched subexpression                 | `(\S+)` captures one or more non-space characters   |
| `\|`      | Logical OR operator (acts as "or" between expressions)               | `cat\|dog` matches "cat" or "dog"                   |
| `{n}`     | Exactly n occurrences of the preceding element                      | `\d{4}` matches exactly four digits                |
| `{n,}`    | n or more occurrences of the preceding element                      | `a{2,}` matches "aa", "aaa", etc.                   |
| `{n,m}`   | Between n and m occurrences of the preceding element                 | `a{1,3}` matches "a", "aa", or "aaa"                |
| `\r`      | Carriage return (used in Windows newline `\r\n`)                     | Use `\r\n` for Windows line breaks                  |
| `\n`      | Newline character (used in Unix and VS Code)                          | Use `\n` for a new line                             |
