# Vimer


This project contains a set of lightweight vimscript functions to expand vim functionality using a custom configuration file for Vim that enhances the editor's functionality and provides an improved user experience without the need of installing plugins. The following features have been added:

- **Last Line Memory** : Vim now remembers and restores the last edited line in the last file opened. No need to worry about losing your place when switching between files.

- **Status Bar Customization**: The status bar has been customized with different colors for specific elements:

    - **Current Filename**: Easily identify the name of the current file you are editing.

    - **Current Function Name**: For Python and JavaScript files, the status bar displays the current function name, making code navigation more convenient.

    - **Cursor Position**: Always know the line and column number of your cursor position.

- **Syntax Coloring**: The popular "afterglow.vim" theme has been applied, providing a visually appealing and comfortable coding environment.

- **Indentation Improvement**: The default indentation has been adjusted to use a 2-space indent, offering a more compact and streamlined coding layout.

- **Line commenter/uncommenter on any indentation level

- Enables deleting in replace mode

```
ChangeLog v0.0.2

- Added support for async javascript function names
- Trimming of larger than 25 characters filename paths

ChangeLog v0.0.3

- Improved statusline colors and trimming for vertical split
- Improved statusline cursor/line/percentage

ChangeLog v0.0.4
- Mapping of key 'M' (Shift + m) to Python line commenter/uncommenter
- Line commenter/uncommenter on any indentation level

ChangeLog v0.0.5
- New function to make backspace delete current char in replace mode instead of moving to the left one position
```

## Installation
You can choose one of the following methods to install this Vim configuration:

### Method 1: Using the install.sh bash script

1. Clone this repository to your local machine.

```
git clone <repository-url>
```
2. Navigate to the cloned directory.

```
cd vimer
```
3. Run the install.sh bash script to automatically copy the vimrc file to your ~/.vimrc.

```
./install.sh
```
### Method 2: Manual Installation
1. Copy the content of the vimrc file from this repository.

2. Open your terminal and create a new ~/.vimrc file or open an existing one.

```
vim ~/.vimrc
```
Paste the copied content into the ~/.vimrc file.

3. Save and exit Vim.

## Get Started
After installation, your Vim editor will be enhanced with the above-mentioned features. Enjoy a more powerful and personalized editing experience tailored to your needs!

Feel free to customize the configuration further to match your preferences and coding style.

If you have any questions or need assistance, please contact me at bernigf@gmail.com

Happy coding!
