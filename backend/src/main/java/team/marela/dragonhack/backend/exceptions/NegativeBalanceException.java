package team.marela.dragonhack.backend.exceptions;

public class NegativeBalanceException extends Exception{
    public NegativeBalanceException(String message) {
        super(message);
    }
}
