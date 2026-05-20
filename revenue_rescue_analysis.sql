-- ==============================================================================
-- PROJECT: CUSTOMER CHURN & REVENUE RESCUE ANALYSIS
-- AUTHOR: Ashwini Damle 
-- ROLE: Business Analyst / HR Operations
-- DESCRIPTION: SQL script to audit subscription data and identify revenue leaks.
-- ==============================================================================

-- CHALLENGE 1: Calculate total Monthly Recurring Revenue (MRR) lost to churn
SELECT SUM(monthly_amount) AS total_lost_mrr
FROM subscriptions 
WHERE status = 'Churned';


-- CHALLENGE 2: Break down the count of cancelled accounts by subscription tier
SELECT tier, COUNT(customer_name) AS churned_customer_count
FROM subscriptions
WHERE status = 'Churned'
GROUP BY tier;


-- CHALLENGE 3: Proactive Risk List - Identify Active customers with low engagement
SELECT 
    subscriptions.customer_name, 
    usage_logs.features_used
FROM subscriptions
INNER JOIN usage_logs 
    ON subscriptions.customer_id = usage_logs.customer_id
WHERE subscriptions.status = 'Active' 
  AND usage_logs.features_used < 20;
