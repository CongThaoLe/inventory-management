package inventory.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;

public class HashingPassword {
	static final String SALT="inventory_management";
	public static String encrypt(String originPassword) {
		String result = null;
		byte[] salt = SALT.getBytes();
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.update(salt);
			byte[] hassPass = md.digest(originPassword.getBytes(StandardCharsets.US_ASCII));
			result = Base64.getEncoder().encodeToString(hassPass).substring(0,32);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(encrypt("1234"));
	}

}
