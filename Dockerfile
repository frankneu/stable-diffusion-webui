# 由cpt生成，若遇到问题请根据实际情况修改

# 采用python或者alpine官方镜像做为运行时镜像
FROM alpine:3.13 

# 设置应用工作目录
WORKDIR /app

# 将所有文件拷贝到容器中
COPY . .

# 安装基础命令
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update --no-cache ca-certificates curl python3 py3-pip tzdata && \
    rm -f /var/cache/apk/*

# 设置时区
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo Asia/Shanghai > /etc/timezone

# 安装python库依赖
RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip3 config set global.trusted-host mirrors.aliyun.com && \
    pip3 install --upgrade pip3 && \
    pip3 install --user -r requirements.txt

# 运行项目
CMD ["webui.sh"]
