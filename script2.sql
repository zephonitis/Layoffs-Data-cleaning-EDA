-- Exploratory Data Analysis

select * from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off) from layoffs_staging2;

select * from layoffs_staging2 where percentage_laid_off = 1 order by funds_raised_millions desc;

select company, sum(total_laid_off) total from layoffs_staging2 group by company order by 2 desc;

select min(`date`), max(`date`) from layoffs_staging2;

select industry, sum(total_laid_off) total from layoffs_staging2 group by industry order by 2 desc;

select * from layoffs_staging2;

select country, sum(total_laid_off) total from layoffs_staging2 group by country order by 2 desc;

select year(`date`), sum(total_laid_off) total from layoffs_staging2 group by year(`date`) order by 1 desc;

select stage, sum(total_laid_off) total from layoffs_staging2 group by stage order by 2 desc;

select company, avg(percentage_laid_off) total from layoffs_staging2 group by company order by 2 desc;


select substring(`date`,1,7) as `month`, sum(total_laid_off) total from layoffs_staging2
where substring(`date`,1,7) is not null group by `month` order by 1;

with Rolling_total as 
(select substring(`date`,1,7) as `month`, sum(total_laid_off) total from layoffs_staging2
where substring(`date`,1,7) is not null group by `month` order by 1) 
select `month`, total, sum(total) over(order by `month`) as rolling_total from Rolling_total;

select substring(`date`,6,2) as `month`, sum(total_laid_off) total from layoffs_staging2
where substring(`date`,6,2) is not null group by `month` order by 2 desc;

select company, sum(total_laid_off) from layoffs_staging2 group by company order by 2 desc;

select company, year(`date`), sum(total_laid_off) from layoffs_staging2 group by company, year(`date`) order by 3 desc;

with Company_year(Company, Years, Total_laid_off) as (select company, year(`date`), sum(total_laid_off) from layoffs_staging2 
group by company, year(`date`)), Company_year_rank as (select *, dense_rank() over(partition by Years 
order by Total_laid_off desc) `rank` from Company_year where Years is not null)
select * from Company_year_rank where `rank` <= 5;

select * from layoffs_staging2;

select percentage_laid_off, ceil(total_laid_off / (1-percentage_laid_off)) employee_before_layoff from layoffs_staging2;
