/**
 * @file my_string.c
 * @author Eric Phan
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-07-05
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(s);
    size_t len = 0;
    while (*s++) {
        len++;
    }
    return len;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(s1);
    // UNUSED_PARAM(s2);
    // UNUSED_PARAM(n);

    size_t count = 0;

    while (*s1 && *s2 && *s1 == *s2 && count < n) {
        count++;
        s2++;
        s1++;
    }
    return *s1 - *s2;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(dest);
    // UNUSED_PARAM(src);
    // UNUSED_PARAM(n);

    char *pointer = dest;
    for (size_t i = n; i > 0; i--) {
        *dest = *src;
        if (*src == 0) {
            return pointer;
        }
        src += sizeof(char);
        dest +=  sizeof(char);
    }
    
    return pointer;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(dest);
    // UNUSED_PARAM(src);
    // UNUSED_PARAM(n);

    char *pointer = dest + my_strlen(dest);
    for (size_t i = 0; i < n; i++) {
        if (*src == '\0') {
            break;
        }
        *pointer = *src;
        pointer++;
        src++;
    }
    size_t index;
    while (index < n) {
        *pointer = '\0';
        pointer++;
        index++;
    }
    return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(str);
    // UNUSED_PARAM(c);
    // UNUSED_PARAM(n);
    
    char *pointer = str;
    for (size_t i = 0; i < n; i++) {
        *pointer = c;
        pointer++;
    }

    return NULL;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(str);
    // UNUSED_PARAM(c);
    int len = my_strlen(str);
    int index = 0;
    if (len == 1) {
        *(str) = '\0';
        return;
    }
    while (index < len) {
        if (*(str + index) == c) {
            break;
        }
        index++;
    }
    if (index == len) {
        return;
    }
    while (index < len) {
        *(str + index) = *(str + index + 1);
        index++;
    }
    return;
}

/**
 * @brief Finds the last instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_last_instance(char *str, char c){
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(str);
    // UNUSED_PARAM(c);
    int len = my_strlen(str);
    int index = my_strlen(str) - 1;
    if (len == 1) {
        *(str) = '\0';
        return;
    }
    while (index > 0) {
        if (*(str + index) == c) {
            break;
        }
        index--;
    }
        if (index == 0) {
        return;
    }   
    while (index < len) {
        *(str + index) = *(str + index + 1);
        index++;
    }
    return;
}

/**
 * @brief Finds the last instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    // UNUSED_PARAM(str);
    // UNUSED_PARAM(c);
    // UNUSED_PARAM(replaceStr);

    char *pointer = NULL;
    int replaceSize = my_strlen(replaceStr);
    // handles empty string case
    if (*replaceStr == 0 || replaceSize == 0) {
        remove_first_instance(str, c);
        return;
    }
    // finds first occurrence of char c
    while (*str != 0) {
        if (*str == c) {
            pointer = str;
        }
        str++;
    }
    // returns if there is no occurrence of c
    if (pointer == NULL) {
        return
    }
    // handles case where replacement string is length 1
    if (replaceSize == 1) {
        *pointer = *replaceStr;
        *str = 0
        return;
    }
    // makes space for string to fit into place of replaced character
    while (str > pointer) {
       *(str + (replaceSize - 1)) = *str;
       str--; 
    }
    // places the string into the place of the replaced character
    while (replaceSize > 0) {
        *pointer = *replaceStr;
        pointer++;
        replaceStr++;
        replaceSize--;
    }
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    UNUSED_PARAM(str);
    (*str)++;
    return;
}