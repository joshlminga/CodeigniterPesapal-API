
--
-- Table structure for table `pesapal_txn`
--

CREATE TABLE `pesapal_txn` (
  `txn_id` bigint(40) NOT NULL,
  `reference_code` bigint(40) NOT NULL,
  `tracking_id` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  `txn_date` datetime NOT NULL,
  `txn_ipn_date` datetime NOT NULL,
  `notification_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `txn_status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `flag` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pesapal_txn`
--
ALTER TABLE `pesapal_txn`
  ADD PRIMARY KEY (`txn_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pesapal_txn`
--
ALTER TABLE `pesapal_txn`
  MODIFY `txn_id` bigint(40) NOT NULL AUTO_INCREMENT;
COMMIT;

