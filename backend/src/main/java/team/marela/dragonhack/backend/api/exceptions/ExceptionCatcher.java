package team.marela.dragonhack.backend.api.exceptions;

import lombok.extern.java.Log;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import team.marela.dragonhack.backend.exceptions.CredentialsInvalidException;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.exceptions.NegativeBalanceException;

import javax.validation.ConstraintViolationException;
import java.util.List;

@Log
@RestController
@ControllerAdvice
public class ExceptionCatcher {

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(value = {DataNotFoundException.class})
    public ExceptionWrapper handleDataNotFoundException(DataNotFoundException exception) {
        log.warning(exception.getMessage());
        return new ExceptionWrapper(List.of(exception.getMessage()));
    }

    @ResponseStatus(HttpStatus.FORBIDDEN)
    @ExceptionHandler(value = {CredentialsInvalidException.class})
    public ExceptionWrapper handleCredentialsInvalidException(CredentialsInvalidException exception) {
        log.warning(exception.getMessage());
        return new ExceptionWrapper(List.of(exception.getMessage()));
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = {ConstraintViolationException.class, NegativeBalanceException.class})
    public ExceptionWrapper handleConstraintViolationException (Exception exception) {
        log.warning(exception.getMessage());
        return new ExceptionWrapper(List.of(exception.getMessage()));
    }
}
