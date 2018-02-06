REPLACE INTO core_config_data (`path`, `value`) VALUES
('lizardsAndPumpkins/data_version/for_export', '-1'),
('lizardsAndPumpkins/magentoconnector/api_url', 'http://127.0.0.1:8080/api.php'),
('lizardsAndPumpkins/magentoconnector/stock_xml_target', NULL),
('lizardsAndPumpkins/magentoconnector/image_target', '/var/www/share/product-images'),
('lizardsAndPumpkins/magentoconnector/local_path_for_product_export', 'file:///var/www/share'),
('lizardsAndPumpkins/magentoconnector/local_filename_template', 'magento-%s.xml'),
('lizardsAndPumpkins/magentoconnector/stores_to_export', '1,2,3'),
('lizardsAndPumpkins/magentoconnector/associated_product_attributes', NULL),
('lizardsAndPumpkins/magentoconnector/disable_tls_peer_verification', '1')
;

DELETE FROM core_config_data WHERE  path = 'design/package/name';
INSERT INTO core_config_data (`path`, `value`) VALUES ('design/package/name', 'lizardsandpumpkins');
