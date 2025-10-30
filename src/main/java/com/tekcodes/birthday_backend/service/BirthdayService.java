package com.tekcodes.birthday_backend.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Service
public class BirthdayService {

    @Value("${birthday.date}")
    private String birthdayDate;

    @Value("${birthday.password}")
    private String birthdayPassword;

    public Map<String, Object> checkBirthday(String password) {
        Map<String, Object> response = new HashMap<>();

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime birthday = LocalDateTime.parse(birthdayDate, DateTimeFormatter.ISO_LOCAL_DATE_TIME);

        // Before birthday → require password & show countdown
        if (now.isBefore(birthday)) {
            if (password == null || !password.equals(birthdayPassword)) {
                response.put("status", "ACCESS_DENIED");
                response.put("message", "Wrong Person Alert 🚫");
                return response;
            }

            Duration duration = Duration.between(now, birthday);
            long days = duration.toDays();
            long hours = duration.toHours() % 24;
            long minutes = duration.toMinutes() % 60;
            long seconds = duration.getSeconds() % 60;

            response.put("status", "COUNTDOWN");
            response.put("message", "Countdown started ⏳");
            response.put("days", days);
            response.put("hours", hours);
            response.put("minutes", minutes);
            response.put("seconds", seconds);
        }
        // On or after birthday → check password again
        else {
            if (password == null || !password.equals(birthdayPassword)) {
                response.put("status", "ACCESS_DENIED");
                response.put("message", "❌ Wrong password! You can’t see the surprise.");
                return response;
            }

            response.put("status", "SURPRISE");
            response.put("message", "🎉 Happy Birthday ❤️🎂");
        }

        return response;
    }
}
