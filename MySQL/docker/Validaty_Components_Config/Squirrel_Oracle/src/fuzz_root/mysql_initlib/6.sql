INSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component4";
INSTALL COMPONENT "file://component_example_component3";
INSTALL COMPONENT "file:component_example_component3";
INSTALL COMPONENT "bad_scheme://component_example_component3";
INSTALL COMPONENT "file:///component_example_component3";
INSTALL COMPONENT "file://./component_example_component3";
INSTALL COMPONENT "file://../component_example_component3";
INSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component4";
UNINSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component2", "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component2", "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
INSTALL COMPONENT "file://component_example_component3", "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
INSTALL COMPONENT "file://component_example_component3", "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component3", "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component3", "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
INSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component2", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component2", "file://component_example_component3";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component3", "file://component_example_component2";
INSTALL COMPONENT "file://component_example_component3";
SELECT COUNT(*) FROM mysql.component;
UNINSTALL COMPONENT "file://component_example_component2", "file://component_example_component2";
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
SELECT COUNT(*) FROM mysql.component;
INSTALL COMPONENT "file://component_example_component1";
INSTALL COMPONENT "file://component_example_component2", "file://component_example_component3";
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
UNINSTALL COMPONENT "file://component_example_component1", "file://component_example_component2", "file://component_example_component3";
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
INSTALL COMPONENT "dynamic_loader_test_lib1";
INSTALL COMPONENT "file://dynamic_loader_test_lib2", "dynamic_loader_test_lib3";
UNINSTALL COMPONENT "fle://dynamic_loader_test_lib1", "file://dynamic_loader_test_lib3";
UNINSTALL COMPONENT "dynamic_loader_test_lib2";
INSTALL COMPONENT "file://localhost/tmp/dynamic_loader_test_lib1";
INSTALL COMPONENT "http://dynamic_loader_test_lib1";
INSTALL COMPONENT "file://dynamic_loader_test_lib2", "http://dynamic_loader_test_lib3";
UNINSTALL COMPONENT "file://dynamic_loader_test_lib1", "http://dynamic_loader_test_lib3";
UNINSTALL COMPONENT "http://dynamic_loader_test_lib2";
INSTALL COMPONENT "file://component_example_component1";
UNINSTALL COMPONENT "file://component_example_component1";
SET @@session.insert_id=42949672950;
