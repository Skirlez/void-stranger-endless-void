# Patches
These are patches to Void Stranger's code that are applied when the `merger.csx` script is ran. 


## For Contributors
Each file can have many different sections. Sections start with a `"TARGET: "` string, and end at the next one or the end of the file.
Each section is processed in order, and the file is recompiled with the new code for every section.
There are an number of targets available to choose from:

- HEAD: Code will be placed at the start
- TAIL: Code will be placed at the end
- LINENUMBER: Code will be placed at the line number in the next line's comment.
It will do so by pushing the code already at that line number downwards, and copying the section's code above it.
- LINENUMBER_REPLACE: Code will be placed at the line number in the next line's comment.
It will do so by removing that line, and copying the section's code to where it once was.
- REPLACE: Completely replaces the file's code with the section's code.
- STRING: Special target. Formatted like so:
```
x>y
```
or
```
x
>
y
```
will replace every sequence of characters matching x with y in the file.

It is a really good idea to leave comments explaining what each section is responsible for.
Note that each section's code should not be indented to match the original file. UndertaleModTool's compiler doesn't care.

Remember to account for the fact that sections are processed individually! This means that if you have two LINENUMBER sections (operating on, in this case, an empty file), like so:
```
// TARGET: LINENUMBER
// 1
code
more code

// TARGET: LINENUMBER
// 2
even more code
even more more code
```
You may expect the result to be:

```
code
more code
even more code
even more more code
```
But it will actually be:

```
code
even more code
even more more code
more code
```

This can be avoided by ordering the LINENUMBER sections, from highest line number to lowest.

- TIP: Use `exit` or `return` to erase entire branches!
- TIP 2: Use LINENUMBER_REPLACE to delete single lines by replacing the line with a comment! As for deleting regions... I've never actually needed to do that... 
