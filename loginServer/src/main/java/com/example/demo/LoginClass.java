package com.example.demo;

import java.util.ArrayList;
import java.util.Optional;

public class LoginClass {

	public boolean login(MemoRepository memoDao, String userId, String userPassword) {
		Long findCount = memoDao.countByUseridAndPassword(userId, userPassword);
		if(findCount <= 0) {
			return false;
		} else {
			return true;
		}
	}
	public boolean logout() {
		return true;
	}
}
