#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mb2sql
PKG_VERSION:=1.0.1
PKG_RELEASE:=1
PKG_MAINTAINER:=Eugen Pyatygin <evgen802@gmail.com>
PKG_LICENSE:=GPL-2
PKG_CONFIG_DEPENDS:=libmodbus libsqlite3 libconfig

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

TARGET_LDFLAGS+= \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib/libconfig/lib \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib/sqlite/lib

define Package/mb2sql
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libmodbus +libsqlite3 +libconfig
  TITLE:=Modbus to SQLite utility program
  URL:=https://github.com/evgen802/mb2sql
  MENU:=1
endef

define Package/mb2sql/description
 Modbus to SQLite is a sample program built using libmodbus libsqlite3 and libconfig
 which polls device by modbus TCP adn creates or opens a user-defined SQLite3 database 
 and performs some simple verification checks on the file to ensure that the target table
 (readings) exists, and if not creates the table, then inserts a row with the current system
 time, and the load time data.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS)
endef

define Package/mb2sql/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mb2sql $(1)/bin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/mb2sql.conf $(1)/etc/config/mb2sql
endef

$(eval $(call BuildPackage,mb2sql))
