# 由cpt生成，若遇到问题请根据实际情况修改

# 采用python或者alpine官方镜像做为运行时镜像
FROM alpine:3.17

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
# RUN apk add cython3 
# RUN apk add python3-pythran 
# RUN apk add libopenblas-dev  
# RUN apk add pkg-config
# RUN apk add libopenblas64-dev 

RUN apk add patchelf 
RUN apk add patch 
RUN apk add libjpeg-turbo-dev 
RUN apk add zlib-dev
RUN apk add make 
RUN apk add automake 
RUN apk add gcc 
RUN apk add g++ 
RUN apk add subversion 
RUN apk add python3-dev 
RUN apk add gfortran 
RUN apk add cmake 
RUN apk add openblas



RUN pip install Pillow --upgrade 

RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

# 安装python库依赖
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip config set global.trusted-host mirrors.aliyun.com && \
    pip install --upgrade pip && \
    pip install --user -r requirements.txt

# 运行项目
CMD ["webui.sh"]
