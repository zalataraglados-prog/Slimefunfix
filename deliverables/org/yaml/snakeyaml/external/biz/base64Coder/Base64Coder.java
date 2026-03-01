package org.yaml.snakeyaml.external.biz.base64Coder;

import java.util.Base64;

public final class Base64Coder {

    private Base64Coder() {}

    public static String encodeLines(byte[] in) {
        if (in == null || in.length == 0) return "";
        return Base64.getEncoder().encodeToString(in);
    }

    public static byte[] decodeLines(String s) {
        if (s == null || s.isEmpty()) return new byte[0];

        String cleaned = s
                .replace("\r", "")
                .replace("\n", "")
                .replace("\t", "")
                .replace(" ", "");

        return Base64.getDecoder().decode(cleaned);
    }
}
