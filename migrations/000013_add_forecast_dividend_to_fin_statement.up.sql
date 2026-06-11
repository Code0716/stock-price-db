ALTER TABLE fin_statement
    ADD COLUMN forecast_dividend_per_share_annual DECIMAL(20,4) NULL COMMENT '1株あたり当期予想配当（年間合計）' AFTER forecast_eps;
