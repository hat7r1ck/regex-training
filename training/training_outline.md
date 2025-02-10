# Regex Training for SOC Analysts and Engineers

---

## **1. Introduction to Regular Expressions (5-10 min)**  
- **What is Regex?**  
  - Definition and purpose in text searching and pattern matching.
  - Real-world analogy: "Regex is like CTRL+F on steroids."

- **Why Regex is Important in Cybersecurity:**  
  - **Log Analysis:** Quickly find indicators of compromise (IOCs) in massive logs.
  - **Alert Tuning:** Create precise detection rules to reduce false positives.
  - **Incident Response:** Extract usernames, IPs, file paths, etc., from raw data.

- **OPSEC Reminder:**  
  - Be cautious when using third-party tools (e.g., regex101) with internal data.

---

## **2. Regex Flavors and Syntax Basics (5 min)**  
### Why Care About Regex Engines?

Different regex engines influence how expressions match strings, where they match, and the speed of matching. Understanding these nuances helps craft efficient and accurate expressions.

### Start Your Engines!

Just like cars have different engines (electric vs. gasoline), regex engines come in two primary types:

1. **DFA (Deterministic Finite Automaton)**: Fast, consistent, and text-directed.
2. **NFA (Nondeterministic Finite Automaton)**: Flexible, regex-directed, and supports backtracking.

### Regex Engine Types and Flavors

1. **DFA Engines** (Electric Engines)
   - **Characteristics**: Fast, consistent, no backreferences, no lazy quantifiers.
   - **Examples**: awk (most versions), egrep (most versions), flex, lex, MySQL, Procmail.

2. **Traditional NFA Engines** (Gas Engines)
   - **Characteristics**: Supports backreferences, lazy quantifiers, and flexible matching.
   - **Examples**: GNU Emacs, Java, grep (most versions), less, more, .NET languages, PCRE library, Perl, PHP, Python, Ruby, sed (most versions), vi.

3. **POSIX NFA Engines**
   - **Characteristics**: Adheres to POSIX standards, deterministic matching.
   - **Examples**: mawk, Mortice Kern Systems’ utilities, GNU Emacs (when requested).

4. **Hybrid NFA/DFA Engines**
   - **Characteristics**: Combines benefits of both DFA and NFA for optimized matching.
   - **Examples**: GNU awk, GNU grep/egrep, Tcl.

---
Lazy Quantifiers aim to match the fewest occurrences of a pattern, unlike greedy quantifiers that match as many as possible.
- Usage: Add a question mark (?) after a quantifier to make it lazy (e.g., a*? matches as few “a”s as possible).
- Also known as: Non-greedy, reluctant, or minimal quantifiers.

Example:
- Greedy: a+ matches all “a”s in “aaaaa”.
- Lazy: a+? matches only the first “a” in “aaaaa”

### Regex Flavors and Engines

Different tools and platforms use varying regex engines and flavors:

- **Chronicle SIEM**: Uses **RE2** engine, a fast and safe DFA-based regex engine.
- **Splunk**: Uses **PCRE (Perl Compatible Regular Expressions)**, offering robust NFA-based capabilities.
- **JavaScript**: NFA engine, supports lazy quantifiers and backreferences.
- **Python**: NFA engine, using the "re" module, supports backreferences and lookaheads.
- **.NET Languages**: NFA engine, supports advanced features like lookbehind and conditional expressions.

### Key Takeaways

- **DFA Engines** are fast and consistent but lack advanced features like backreferences.
- **NFA Engines** offer flexibility with features like lazy quantifiers and backtracking but can be slower.
- **POSIX NFA** ensures deterministic matching adhering to strict standards.
- **Hybrid Engines** leverage the strengths of both DFA and NFA.

Understanding the underlying engine helps in crafting efficient, accurate, and optimized regular expressions for various platforms and tools.

---

## **3. Core Regex Concepts (15-20 min)**  
Break down the essentials needed for the hands-on practice.

### **a) Basic Characters & Meta Characters**  
- `.` – Matches **any character** except newline.
- `\` – **Escape character** (e.g., `\.` , `\(` to match a literal dot or parenthesis).

### **b) Character Classes & Sets**  
- `[abc]` – Matches **any** one of the characters *a*, *b*, or *c*.
- `[^abc]` – **Negation:** Matches anything **except** *a*, *b*, or *c*.
- `\d`, `\w`, `\s` – **Shorthand** for digits, word characters, and whitespace.
- `[A-Za-z0-9_]` – **Custom ranges**.

### **c) Quantifiers (Repetitions)**  
- `*` – **0 or more** times.
- `+` – **1 or more** times.
- `?` – **0 or 1** (optional).
- `{n}`, `{n,}`, `{n,m}` – **Exact, minimum, or range repetitions**.  
  - Example: `\d{1,4}` to match 1 to 4 digits.

### **d) Anchors**  
- `^` – Start of a string.
- `$` – End of a string.  
  - Example: `^John` matches "John" only at the start of a string.

### **e) Grouping and Capturing**  
- `()` – **Capture groups** for extracting specific data.  
  - Example: `(\d{4})-(\d{2})-(\d{2})` captures a date format.
- `(?: )` – **Non-capturing groups** (group without saving for extraction).

### **f) Alternation (OR Logic)**  
- `|` – Acts like an **OR**.  
  - Example: `John|Jane|Alice` matches **John**, **Jane**, or **Alice**.

### **g) Lookaheads and Lookbehinds (Advanced Concepts)**  
*(Optional if the group is very new)*  
- `(?=...)` – **Positive Lookahead** (something must follow).
- `(?<=...)` – **Positive Lookbehind** (something must precede).

---

## **4. Practical Cybersecurity Use Cases (5 min)**  
Examples of how regex helps in SOC operations.

- **Log Parsing:**  
  - Extract IPs: `\b\d{1,3}(?:\.\d{1,3}){3}\b`
  - Find email addresses: `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b`

- **SIEM Rule Tuning:**  
  - Detect file paths: `C:\\\\[A-Za-z0-9_\\\\\-\.]+`
  - Match suspicious PowerShell commands: `powershell.exe\s.*-EncodedCommand\s`

---

## **5. Hands-On Exercise Instructions (30 min)**  
This is where the **practice script** comes in.

1. **Distribute the Zip Files**  
   - Each participant opens their `.txt` file with name variations.

2. **Hands-On Tasks:**  
   - **Task 1:** Write a regex pattern to match all variations of your name.
   - **Task 2:** Add anchors (`^`, `$`) to match full names precisely.

3. **Task Answer:**  
   - Decode the **Base64** answer in your file to compare your regex with the solution.

---

## **6. Wrap-Up & Q&A (5 min)**  
- Quick recap of concepts.
- Provide a **cheat sheet** with regex syntax for future reference.
- Invite questions or examples they’ve encountered in the field.

---

## **Optional Add-ons:**  
- **CyberChef Live Demo:** Show how to test their patterns in CyberChef.

