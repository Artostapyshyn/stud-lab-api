package com.artostapyshyn.studlabapi.service;

import com.artostapyshyn.studlabapi.dto.SignUpDto;
import com.artostapyshyn.studlabapi.entity.Student;
import org.springframework.security.core.Authentication;

import java.util.List;
import java.util.Optional;

public interface StudentService {
    Optional<Student> findById(Long id);

    Student findByEmail(String email);

    Student save(Student student);

    List<Student> findAll();

    void deleteById(Long id);

    Student findByFirstNameAndLastName(String firstName, String lastName);

    Long getAuthStudentId(Authentication authentication);

    void updateStudent(Student existingStudent, Student updatedStudent);

    void updatePassword(Student student, String password);

    void signUpStudent(SignUpDto signUpDto, Student existingStudent);
}
