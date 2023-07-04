/**
 * @file my_string.c
 * @author YOUR NAME HERE
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-xx
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
    UNUSED_PARAM(s);
    
    return 0;
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
    UNUSED_PARAM(s1);
    UNUSED_PARAM(s2);
    UNUSED_PARAM(n);

    return 0;
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
    UNUSED_PARAM(dest);
    UNUSED_PARAM(src);
    UNUSED_PARAM(n);
    
    return NULL;
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
    UNUSED_PARAM(dest);
    UNUSED_PARAM(src);
    UNUSED_PARAM(n);
    
    return NULL;
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
    UNUSED_PARAM(str);
    UNUSED_PARAM(c);
    UNUSED_PARAM(n);
    
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
    UNUSED_PARAM(str);
    UNUSED_PARAM(c);
    
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
    UNUSED_PARAM(str);
    UNUSED_PARAM(c);
    
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
    UNUSED_PARAM(str);
    UNUSED_PARAM(c);
    UNUSED_PARAM(replaceStr);
    
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
    
    return;
}