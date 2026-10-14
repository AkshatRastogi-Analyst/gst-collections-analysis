# GST Collections Analysis: Full Year FY 2025-26 (India)

## Business question
How much GST did India collect in a full year, how did each month compare with the same month last year, and which part (domestic sales or imports) is growing faster?

## Data
- Official monthly GST revenue releases (Ministry of Finance / GST Network), in Rs crore.
- All 12 months of FY 2025-26 (April 2025 to March 2026), each compared with the same month of FY 2024-25.
- Gross GST here means CGST + SGST + IGST. Cess is not included, so both years are compared fairly.
- Full-year split: domestic sales and imports (domestic = total minus imports).
- Files: `gst_analysis.sql` (tables and queries), `index.html` (dashboard), and 2 CSV files.

## Data check
- My 12 months add up to Rs 22,27,096 crore for FY 2025-26, the same as the official full-year total.
- For FY 2024-25 my months add up to Rs 20,55,516 crore. The official total is Rs 20,55,515 crore. The Rs 1 crore difference is rounding.
- Numbers can look different from news reports in 2025 because those reports included cess.

## Steps
1. Collected the monthly numbers from the official releases and checked that they add up to the official full-year totals.
2. Put the data in PostgreSQL tables.
3. Worked out growth for every month, every quarter and the full year.
4. Compared domestic sales with imports.
5. Made a one-page dashboard.

## Findings
- GST grew about 8.3% in the full year: Rs 22,27,096 crore against Rs 20,55,515 crore.
- April is the biggest month in both years (Rs 2,23,265 crore in April 2025).
- May grew the fastest (+17.3%) and November the slowest (+0.7%).
- April to June grew 12.4%. October to December grew only 4.8%.
- Imports grew 14.1% and domestic GST grew 6.4%. Imports are now about 26.7% of the total.

## Recommendations
1. Plan for April, the peak month, every year.
2. Look into why growth slowed in October to December, after the GST rate cut in late September 2025.
3. Track imports separately, since they grow faster than domestic GST.

## Limits
Only total GST is used, not state-wise or product-wise numbers. Official numbers are provisional and may be revised.

## Live Site Link
Live Site - https://akshatrastogi-analyst.github.io/gst-collections-analysis/
