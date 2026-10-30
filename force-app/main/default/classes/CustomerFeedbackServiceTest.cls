/**
 * @description Test class for CustomerFeedbackService
 * @author Build Agent
 * @date 2026-10-29
 */
@isTest
private class CustomerFeedbackServiceTest {
    
    /**
     * @description Test creating feedback with valid rating in middle of range
     */
    @isTest
    static void createFeedback_WithValidRating_ShouldSucceed() {
        // Arrange
        Decimal validRating = 3;
        
        // Act
        Test.startTest();
        Id feedbackId = CustomerFeedbackService.createFeedback(validRating);
        Test.stopTest();
        
        // Assert
        System.assertNotEquals(null, feedbackId, 'Feedback ID should not be null');
        
        Customer_Feedback__c insertedFeedback = [
            SELECT Id, Rating__c 
            FROM Customer_Feedback__c 
            WHERE Id = :feedbackId
        ];
        System.assertEquals(validRating, insertedFeedback.Rating__c, 'Rating should match input');
    }
    
    /**
     * @description Test creating feedback with rating below minimum (boundary test)
     */
    @isTest
    static void createFeedback_WithRatingBelowMinimum_ShouldThrowException() {
        // Arrange
        Decimal invalidRating = 0;
        Boolean exceptionThrown = false;
        
        // Act
        Test.startTest();
        try {
            CustomerFeedbackService.createFeedback(invalidRating);
        } catch (FeedbackException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('Rating must be between 1 and 5'), 
                'Exception message should indicate rating range');
        }
        Test.stopTest();
        
        // Assert
        System.assertEquals(true, exceptionThrown, 'FeedbackException should be thrown for rating below 1');
    }
    
    /**
     * @description Test creating feedback with rating above maximum (boundary test)
     */
    @isTest
    static void createFeedback_WithRatingAboveMaximum_ShouldThrowException() {
        // Arrange
        Decimal invalidRating = 6;
        Boolean exceptionThrown = false;
        
        // Act
        Test.startTest();
        try {
            CustomerFeedbackService.createFeedback(invalidRating);
        } catch (FeedbackException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('Rating must be between 1 and 5'), 
                'Exception message should indicate rating range');
        }
        Test.stopTest();
        
        // Assert
        System.assertEquals(true, exceptionThrown, 'FeedbackException should be thrown for rating above 5');
    }
    
    /**
     * @description Test creating feedback with null rating
     */
    @isTest
    static void createFeedback_WithNullRating_ShouldThrowException() {
        // Arrange
        Decimal nullRating = null;
        Boolean exceptionThrown = false;
        
        // Act
        Test.startTest();
        try {
            CustomerFeedbackService.createFeedback(nullRating);
        } catch (FeedbackException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('Rating cannot be null'), 
                'Exception message should indicate null rating');
        }
        Test.stopTest();
        
        // Assert
        System.assertEquals(true, exceptionThrown, 'FeedbackException should be thrown for null rating');
    }
}