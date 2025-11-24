package csd430.beans;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 * Clint Scott
 * CSD 430
 * Module 7 Project Part 2
 * 11/23/2025
 *
 * Utility class providing AES-256 encryption and decryption services 
 * for securing database credentials.
 */
public class SecurityUtil {

    // 32-character key required for AES-256 encryption
    private static final String KEY = "MySuperSecretKeyForCSD430Project"; 

    /**
     * Encrypts a plain text string using AES-256.
     * @param strToEncrypt The plain text string
     * @return Base64 encoded encrypted string or null on failure
     */
    public static String encrypt(String strToEncrypt) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes()));
        } catch (Exception e) {
            System.err.println("Encryption Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Decrypts a Base64 encoded AES-256 string.
     * @param strToDecrypt The encrypted string
     * @return Plain text string or null on failure
     */
    public static String decrypt(String strToDecrypt) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
        } catch (Exception e) {
            System.err.println("Decryption Error: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Main method for generating encrypted password strings.
     * Run strictly for generation purposes.
     */
    public static void main(String[] args) {
        String myPassword = "pass"; 
        System.out.println("Encrypted Password: " + encrypt(myPassword));
    }
}