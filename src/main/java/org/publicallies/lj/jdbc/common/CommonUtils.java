package org.publicallies.lj.jdbc.common;

/**
 * Common Utility class.
 * 
 * @author wilsa
 *
 */
public class CommonUtils {


    /**
     * This will clean strings for sql insertions. It will skip non string characters
     * 
     * @param obj object to clean.
     * @return
     */
    public static String cleanStringForSqlInsertion(String obj) {
        if (obj != null) {
            obj = obj.replaceAll("\u0091", "'").replaceAll("\u0092", "'").replaceAll("\u0093", "\"")
                    .replaceAll("\u0094", "\"").replaceAll("\u0097", "...");
        }

        return obj;
    }

}
