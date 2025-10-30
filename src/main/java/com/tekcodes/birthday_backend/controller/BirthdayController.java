package com.tekcodes.birthday_backend.controller;

import com.tekcodes.birthday_backend.service.BirthdayService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@CrossOrigin(origins = "https://birthday-frontend-orpin.vercel.app/")
@RequestMapping("/api")
public class BirthdayController {

    private final BirthdayService birthdayService;

    public BirthdayController(BirthdayService birthdayService) {
        this.birthdayService = birthdayService;
    }

    @PostMapping("/check")
    public Map<String, Object> checkBirthday(@RequestBody(required = false) Map<String, String> body) {
        String password = (body != null) ? body.get("password") : null;
        return birthdayService.checkBirthday(password);
    }
}
