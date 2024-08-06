-- macros/calculate_amounts.sql

{% macro calculate_discounted_amount(amount, discount_percent) %}
    (
        {{ amount }} * (1 - coalesce({{ discount_percent }}, 0) / 100)
    )
{% endmacro %}

{% macro calculate_amount_with_tax(discounted_amount, tax_percent) %}
    (
        {{ discounted_amount }} * (1 + coalesce({{ tax_percent }}, 0) / 100)
    )
{% endmacro %}
