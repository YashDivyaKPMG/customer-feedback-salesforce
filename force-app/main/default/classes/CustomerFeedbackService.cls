/**
 * @description Service class for Customer Feedback operations
 * @author Build Agent
 * @date 2026-10-29
 */
public with sharing class CustomerFeedbackService {
    
    /**
     * @description Creates a new Customer Feedback record with the given rating
     * @param rating The customer rating (must be between 1 and 5)
     * @return Id of the created Customer_Feedback__c record
     * @throws FeedbackException if rating is invalid or DML fails
     */
    public static Id createFeedback(Decimal rating) {
        // Validate input parameter
        if (rating == null) {
            throw new FeedbackException('Rating cannot be null');
        }
        
        // Validate rating range (defensive check before DML)
        if (rating < 1 || rating > 5) {
            throw new FeedbackException('Rating must be between 1 and 5');
        }
        
        // Create feedback record
        Customer_Feedback__c feedback = new Customer_Feedback__c(
            Rating__c = rating
        );
        
        try {
            insert feedback;
            return feedback.Id;
        } catch (DmlException e) {
            throw new FeedbackException('Failed to create feedback: ' + e.getMessage());
        }
    }
}