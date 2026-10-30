/**
 * @description Centralized test data factory for creating test records
 * @author Build Agent
 * @date 2026-10-29
 */
@isTest
public class TestDataFactory {
    
    /**
     * @description Creates a single Customer_Feedback__c record with specified rating
     * @param rating The rating value (1-5)
     * @param doInsert Whether to insert the record or just return it
     * @return Customer_Feedback__c record
     */
    public static Customer_Feedback__c createFeedback(Decimal rating, Boolean doInsert) {
        Customer_Feedback__c feedback = new Customer_Feedback__c(
            Rating__c = rating
        );
        
        if (doInsert) {
            insert feedback;
        }
        
        return feedback;
    }
    
    /**
     * @description Creates multiple Customer_Feedback__c records
     * @param count Number of records to create
     * @param rating Rating value for all records
     * @param doInsert Whether to insert the records or just return them
     * @return List of Customer_Feedback__c records
     */
    public static List<Customer_Feedback__c> createFeedbacks(Integer count, Decimal rating, Boolean doInsert) {
        List<Customer_Feedback__c> feedbacks = new List<Customer_Feedback__c>();
        
        for (Integer i = 0; i < count; i++) {
            feedbacks.add(new Customer_Feedback__c(
                Rating__c = rating
            ));
        }
        
        if (doInsert) {
            insert feedbacks;
        }
        
        return feedbacks;
    }
}