FROM python:3.11

ENV PATH=$PATH:/root/.cargo/bin
RUN curl https://sh.rustup.rs -sSf > /rust.sh && sh /rust.sh -y \
    && rustup install stable

RUN apt update && \
    apt upgrade -y && \
    apt install -y libsndfile1 && \
    apt install -y ffmpeg


WORKDIR /app
COPY ["requirements.txt", "Makefile", "./"]
RUN pip install -r requirements.txt
COPY configs.yaml .
COPY src/ src/

RUN yes | python -c "from TTS.api import TTS; TTS(model_name='tts_models/multilingual/multi-dataset/xtts_v2')"
