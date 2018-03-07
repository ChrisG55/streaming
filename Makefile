MVN ?= mvn

all: jedis YCSB

clean:
	cd jedis && make cleanup
	cd YCSB && $(MVN) clean

jedis:
	cd jedis && make package

YCSB: jedis
	cd YCSB && $(MVN) install:install-file \
	-DlocalRepositoryPath=redis/repo -DcreateChecksum=true -Dpackaging=jar \
	-Dfile=../jedis/target/jedis-2.9.1-STREAMING.jar \
	-DgroupId=redis.clients -DartifactId=jedis -Dversion=2.9.1-STREAMING \
	-X && $(MVN) -pl com.yahoo.ycsb:redis-binding -am clean package -X

.PHONY: all clean jedis YCSB
