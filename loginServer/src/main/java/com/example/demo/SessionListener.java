package com.example.demo;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SessionListener implements HttpSessionListener {

    @Autowired
    private LsRepository lsDao;

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        String userId = (String) se.getSession().getAttribute("loginok");

        if (userId != null) {
            List<Ls> lsList = lsDao.findByUserId(userId);
            if (lsList != null && !lsList.isEmpty()) {
                for (Ls ls : lsList) {
                    if (ls.getValue() != 0) {
                        ls.setValue(0);
                        lsDao.save(ls);
                    }
                }
            }
        }
    }
}