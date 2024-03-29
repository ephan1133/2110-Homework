// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "oh_queue.h"

struct Queue oh_queue;


/** enqueue
 * @brief Create a new student and enqueue him
 * onto the OH queue
 * @param studentName pointer to the student's name
 * @param topicName topic the student has a question on
 * @param questionNumber hw question number student has a question on
 * @param pub_key public key used for calculating the hash for customID
 * @return FAILURE if the queue is already at max length, SUCCESS otherwise
 */
int enqueue(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    UNUSED_PARAM(studentName);
    UNUSED_PARAM(topicName);
    UNUSED_PARAM(questionNumber);
    UNUSED_PARAM(pub_key);

    if (oh_queue.stats.no_of_people_in_queue >= MAX_QUEUE_LENGTH || *studentName == '\0') {
        return FAILURE;
    }
    struct Student student; 
    char *name = student.studentData.name;
    int i = 1;
    while (i < MAX_NAME_LENGTH && *studentName != 0) {
        *name = *studentName;
        name++;
        studentName++;
        i++;
    }
    *name = 0;

    student.studentData.topic.topicName = topicName;
    student.studentData.topic.questionNumber = questionNumber;
    // student.queue_number = oh_queue.stats.no_of_people_in_queue + oh_queue.stats.no_of_people_visited;
    hash(student.customID, student.studentData.name, pub_key);
    student.queue_number = oh_queue.stats.no_of_people_in_queue;
    oh_queue.students[oh_queue.stats.no_of_people_in_queue] = student;
    oh_queue.stats.no_of_people_in_queue++;
    oh_queue.stats.no_of_people_visited++;
    OfficeHoursStatus(&oh_queue.stats);
    return SUCCESS;
}

/** dequeue
 * @brief remove a student out the OH queue
 * @return FAILURE if the queue is already at empty, SUCCESS otherwise
 */
int dequeue(void) {
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        return FAILURE;
    }
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue - 1; i++) {
        oh_queue.students[i] = oh_queue.students[i + 1];
    }
    oh_queue.stats.no_of_people_in_queue--;
    oh_queue.stats.no_of_people_visited++;
    OfficeHoursStatus(&oh_queue.stats);
    return SUCCESS;
}

/** group_by_topic
 * @brief add pointers to students, who match the given topic, to
 * the given array "grouped"
 * @param topic the topic the students need to match
 * @param grouped an array of pointers to students
 * @return the number of students matched
 */
int group_by_topic(struct Topic topic, struct Student *grouped[]) {
    int counter = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
            if (oh_queue.students[i].studentData.topic.topicName == topic.topicName && 
                oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber) {
                grouped[counter] = &oh_queue.students[i];
                counter++;
            }
    }
    return counter;
}

/** hash
 * @brief Creates a hash based on pub_key provided
 * @param ciphertext the pointer where you will store the hashed text
 * @param plaintext the originak text you need to hash
 * @param pub_key public key used for calculating the hash
 */
void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    int len = my_strlen(plaintext);
    char *pointer = plaintext;
    for (int i = 0; i < len; i++) {
        *ciphertext = power_and_mod(*pointer, pub_key.e, pub_key.n);
        pointer++;
        ciphertext++;
    }
    return;
}

/** update_student
 * @brief Find the student with the given ID and update his topic
 * @param customID a pointer to the id of the student you are trying to find
 * @param newTopic the new topic that should be assigned to him
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int update_student(struct Topic newTopic, int *customID) {
    int queueSize = oh_queue.stats.no_of_people_in_queue;
    int found = 0;
    for (int i = 0; i < queueSize; i++) {
        int id = *oh_queue.students[i].customID;
        if (id == *customID) {
            found = 1;
            oh_queue.students[i].studentData.topic = newTopic;
        }
    }
    if (found == 0) {
        return FAILURE;
    }
    return SUCCESS;
}

/** remove_student_by_name
 * @brief Removes first instance of a student with the given name
 * @param name the name you are searching for
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_name(char *name){
    int found = 0;
    int index = 0;
    for (index = 0; index < oh_queue.stats.no_of_people_in_queue; index++) {
        if (my_strncmp(name, oh_queue.students[index].studentData.name, my_strlen(oh_queue.students[index].studentData.name)) == 0) {
            found = 1;
            break;
        }
    }
    if (found == 0) {
        return FAILURE;
    }
    for (; index < oh_queue.stats.no_of_people_in_queue - 1; index++) {
        oh_queue.students[index] = oh_queue.students[index + 1];
    }
    oh_queue.stats.no_of_people_in_queue--;
    oh_queue.stats.no_of_people_visited++;
    OfficeHoursStatus(&oh_queue.stats);


    return SUCCESS;
}

/** remove_student_by_topic
 * @brief Remove all instances of students with the given topic
 * @param topic the topic you are trying to remove from the queue
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_topic(struct Topic topic) {
    int counter = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
            if (oh_queue.students[i].studentData.topic.topicName == topic.topicName && 
                oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber) {
                remove_student_by_name(oh_queue.students[i].studentData.name);
                i--;
                counter++;
            }
    }
    if (counter == 0) {
        return FAILURE;
    }
    return SUCCESS;
}

/** OfficeHoursStatus
 * @brief Updates the "currentStatus" field based on
 * whether or not all students in the queue have been helped
 * @param resultStats A pointer the OfficeHoursStats variable
 * you are to update
 */
void OfficeHoursStatus(struct OfficeHoursStats* resultStats){
    if (resultStats->no_of_people_in_queue == 0) {
        resultStats->currentStatus = "Completed";
    } 
    if (resultStats->no_of_people_in_queue > 0) {
        resultStats->currentStatus = "InProgress";
    }
    return;
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}
