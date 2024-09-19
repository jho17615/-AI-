package com.example.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LsRepository extends JpaRepository<Ls, Long> {
	List<Ls> findByUserId(String userId);
	Ls findByUserIdEquals(String userId);
	List<Ls> findByValueEquals(Integer value); 
}