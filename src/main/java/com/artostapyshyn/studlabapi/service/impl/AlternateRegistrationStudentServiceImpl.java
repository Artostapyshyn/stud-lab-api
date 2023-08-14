package com.artostapyshyn.studlabapi.service.impl;

import com.artostapyshyn.studlabapi.entity.AlternateRegistrationStudent;
import com.artostapyshyn.studlabapi.repository.AlternateRegistrationStudentRepository;
import com.artostapyshyn.studlabapi.service.AlternateRegistrationStudentService;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class AlternateRegistrationStudentServiceImpl implements AlternateRegistrationStudentService {

    private final AlternateRegistrationStudentRepository alternateRegistrationStudentRepository;

    @Cacheable(value = "allAlternateRegistrationStudents")
    @Override
    public List<AlternateRegistrationStudent> findAll() {
        return alternateRegistrationStudentRepository.findAll();
    }

    @Cacheable(value = "alternateRegistrationStudentById")
    @Override
    public Optional<AlternateRegistrationStudent> findById(Long id) {
        return alternateRegistrationStudentRepository.findById(id);
    }

    @CachePut(value = {"allAlternateRegistrationStudents", "alternateRegistrationStudentById"})
    @Transactional
    @Override
    public AlternateRegistrationStudent save(AlternateRegistrationStudent alternateRegistrationStudent) {
        return alternateRegistrationStudentRepository.save(alternateRegistrationStudent);
    }

    @CacheEvict(value = {"allAlternateRegistrationStudents", "alternateRegistrationStudentById"})
    @Transactional
    @Override
    public void delete(AlternateRegistrationStudent alternateRegistrationStudent) {
        alternateRegistrationStudentRepository.delete(alternateRegistrationStudent);
    }

    @Override
    public boolean isValidCode(String code) {
        return alternateRegistrationStudentRepository.existsByCode(code);
    }

    @Cacheable(value = "alternateRegistrationStudentByCode")
    @Override
    public Optional<AlternateRegistrationStudent> findByCode(String code) {
        return alternateRegistrationStudentRepository.findByCode(code);
    }
}
