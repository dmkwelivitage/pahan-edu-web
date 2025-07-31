package com.uni.service;

import com.uni.dao.UserDAO;
import com.uni.dto.LoginRequestDTO;
import com.uni.dto.UserDTO;
import com.uni.model.User;

public class AuthService {
    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public UserDTO login(LoginRequestDTO loginDTO) {
        User user = userDAO.validateUser(loginDTO.getUsername(), loginDTO.getPassword());

        if (user != null) {
            return new UserDTO(user.getId(), user.getUsername(), user.getRole());
        }

        return null;
    }
}
