--- converts to cm and kg ---
CAST(
            CASE
                WHEN unit_system = 'imperial' AND height > 100 THEN height
                WHEN unit_system = 'imperial' AND height < 9 THEN height * 30.48
                WHEN unit_system = 'imperial' THEN height * 2.54
                WHEN unit_system = 'metric' AND height < 3 THEN height * 100
                ELSE height
            END AS INT64
        ) AS height_cm
CASE
            WHEN unit_system = 'imperial' AND weight < 80 THEN weight
            WHEN unit_system = 'imperial' THEN ROUND(weight * 0.453592, 2)
            ELSE weight
        END AS weight_kg,
        CASE
            WHEN unit_system = 'imperial' AND target_weight < 80 THEN target_weight
            WHEN unit_system = 'imperial' THEN ROUND(target_weight * 0.453592, 2)
            ELSE target_weight
        END AS target_weight_kg

--- adjusts bmi ---

CASE
            WHEN bmi BETWEEN 12 AND 70 THEN bmi

            WHEN height_cm >= 70 AND weight_kg >= 30
                THEN ROUND(weight_kg / NULLIF(POW(height_cm / 100, 2), 0), 2)
            ELSE bmi
        END AS corrected_bmi

--- mass to lose ---

ROUND((metric.target_weight_kg - metric.weight_kg) / NULLIF(metric.weight_kg, 0), 3)

--- categories ---

CASE
            WHEN (metric.target_weight_kg - metric.weight_kg) / NULLIF(metric.weight_kg, 0) > -0.05 THEN '<5%'
            WHEN (metric.target_weight_kg - metric.weight_kg) / NULLIF(metric.weight_kg, 0) <= -0.05
                AND (metric.target_weight_kg - metric.weight_kg) / NULLIF(metric.weight_kg, 0) > -0.10 THEN '5%-10%'
            WHEN (metric.target_weight_kg - metric.weight_kg) / NULLIF(metric.weight_kg, 0) <= -0.50 THEN '>50%'
        END AS body_mass_to_lose_category

--- pivot to columns ---

        MAX(CASE WHEN field = 'diabetes_type' THEN value END) AS diabetes_type,
        MAX(CASE WHEN field = 'activity_level' THEN value END) AS activity_level,
        MAX(CASE WHEN field = 'allergies' THEN value END) AS allergies

--- REGEXP_REPLACE ---

CASE
      WHEN REGEXP_REPLACE(LOWER(diabetes_type), r'[^a-z0-9]', '') LIKE ANY ('%type1%', '%typeą%') THEN 'Type 1'
      ELSE NULL
    END

CASE
      WHEN LOWER(activity_level) IN ('not active', 'inactive', '1') THEN 'Not Active'
      ELSE NULL
    END

--- allergies ---

CASE
      WHEN allergies IS NULL THEN NULL
      WHEN REGEXP_CONTAINS(allergies, r'"lactose"') THEN TRUE
      ELSE FALSE
    END AS allergy_lactose

--- purchase sum ---

COUNTIF(orders.order_type IN ('initial', 'recurring')) AS payment_count
COUNTIF(orders.order_type = 'initial' AND refunds.order_id IS NOT NULL) > 0 AS refunded_initial
