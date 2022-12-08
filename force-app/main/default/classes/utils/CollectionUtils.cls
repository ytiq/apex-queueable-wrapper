public class CollectionUtils {
    public static Set<Id> pickIds(List<SObject> collection, SObjectField field) {
        Set<Id> result = new Set<Id>();
        DescribeFieldResult describeFieldResult = field.getDescribe();

        if (describeFieldResult.type != DisplayType.REFERENCE && describeFieldResult.type != DisplayType.ID) {
            throw new CustomException('field type is not lookup - ' + field);
        }
        if (collection == null) {
            return result;
        }

        for (SObject sobj : collection) {
            result.add((Id) sobj.get(field));
        }

        return result;
    }
    public static Set<String> pickStrings(List<SObject> collection, SObjectField field) {
        Set<String> result = new Set<String>();

        if (collection == null) {
            return result;
        }

        for (SObject sobj : collection) {
            result.add((String) sobj.get(field));
        }

        return result;
    }
    public class CustomException extends Exception {

    }

}
