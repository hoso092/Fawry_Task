# mygrep.sh - Mini Grep Implementation

## 🛠️ Implementation Breakdown

### Argument and Option Handling
The script handles arguments and options through the following logic:

1. **Help Option Check**  
   - First checks for `--help` or `-h` flags to display usage information  
   - Uses a dedicated `show_help()` function for clean, formatted output  

2. **Argument Validation**  
   - Verifies correct number of arguments (2-3)  
   - Rejects invalid argument counts with descriptive error messages  

3. **Option Parsing**  
   - Detects options (`-n`, `-v`) by checking for leading hyphens  
   - Supports combined options (`-vn`, `-nv`) through substring matching  
   - Separates options, pattern, and filename into distinct variables  

4. **File Validation**  
   - Checks file existence with proper error handling  
   - Verifies read permissions before processing  
   - Handles empty files gracefully  

5. **Pattern Validation**  
   - Ensures non-empty search pattern  
   - Provides grep-style error messaging  

### Search Execution
- **Case-Insensitive Matching**: Uses `${var,,}` parameter expansion  
- **Inverted Matching**: Implements `-v` option logic  
- **Line Numbers**: Adds numbering with `-n` option  
- **Color Highlighting**: Uses ANSI escape codes via `sed`  

## 🔮 Potential Enhancements

1. **Regex Support**  
   - Add pattern type detection (simple vs regex)  
   - Implement proper regex matching logic  
   - Update error handling for invalid patterns  

2. **Additional Flags**  
   - `-c` for match counting  
   - `-l` for filename-only output  
   - `-i` for explicit case-insensitive flag
   - Implement logic for each new flag
   - Update argument validation to accept new flags
   - Update help text to reflect new flags  

## 🎛️ Implementation Challenges

1. **Combined Option Handling**  
   Developed robust parsing logic that handles:  
   - Combined flags (`-vn`)  
   - Separate flags (`-v -n`)  
   - Positional variations  

2. **Edge Case Validation**  
   Implemented comprehensive checks for:  
   - Missing arguments  
   - Invalid file states  
   - Empty patterns/files  

3. **Case-Insensitive Matching**  
   Choose Bash-native `${var,,}` instead of awk/grep `-i` because it:  
   - Requires zero external dependencies  
   - Provides consistent behavior across Bash versions  
   - Offers better performance for small-to-medium files  

   *Trade-off*: Limited to simple patterns (intentional scope limitation)  

## ✅ Validation Testing

The script was verified with:  
✔ Basic pattern matching  
✔ All option combinations (`-n`, `-v`, `-vn`)  
✔ Edge cases:  
   - Special characters in patterns  
   - Missing files  
   - Unreadable files  
   - Empty files/patterns  

Test outputs match grep's behavior for all specified requirements.