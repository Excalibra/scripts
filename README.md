## Disclaimer: All content is for informational research, learning, and exchange purposes only, to be used in a lawful and compliant manner. Thank you.

## Introduction

The project involves interdisciplinary applications and analysis of information: desktop baseline checks, software activation/cracking, antivirus evasion and privilege escalation, firmware identification and read/write for penetration support, host account null password detection, Wi-Fi password scanning, cloud host security hardening, host system log analysis, natural language processing, and data analysis in humanities and social sciences.

* **System Platforms**: Windows/Mac/Linux; **Scripting Languages**: Multiple, flexible; customized as needed.
* **Research Focus**: Basic information automation, cloud host/local desktop security processing, social science information technology, and data analysis.

The project code involves component version compatibility issues. <a href="https://nbviewer.org/github/Excalibra/scripts/blob/main/d-ipynb/Platform%20Compatibility%20Issues.ipynb">Click here</a> for more details; regarding the inability to preview ipynb on GitHub, [please refer here](https://blog.reviewnb.com/jupyter-notebook-not-rendering-on-github/); to generate automated information processing reports, check the [d-xlsx](./d-xlsx) directory for more details.

## Analysis of Common Platform Hot Searches and Rumor Refutation

This section involves interdisciplinary and basic research of humanities and social science journals and paper research subjects (including colleague interviews, online forum surveys, etc.).

* HTML web page parsing, web UI automation
* Data collection, filtering, classification, and archiving
* Basic mathematical statistics of "averages/extremes," word segmentation, sentiment value calculation and summary (natural language processing)

<details>
<summary>Basic operations when first starting, simple information collection test.</summary>

<p>One-click access to Chita.ru News information <a href="https://dev.to/excalibra/python-skript-dlia-poluchieniia-novostiei-s-saita-chitaru-2nhc">Text version</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghp.ci/https://raw.githubusercontent.com/Excalibra/scripts/main/d-python/get_chita_news.py)"
</code></pre>

<p>One-click access to Chita.ru News information in Ruby</p>

<pre><code>ruby -e "$(curl -fsSL https://ghp.ci/https://raw.githubusercontent.com/Excalibra/scripts/main/d-ruby/get_chita_news.rb)"
</code></pre>

<p>One-click generate global information reports <a href="#">Text version</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://github.com/Excalibra/scripts/blob/main/d-python/get_worldometers.py)"
</code></pre>

<p>One-click collect the top five answers from Zhihu</p>
<pre><code>python3 -c "$(curl -fsSL #)"</code></pre>

<p>Collect 90 job posts and salary details from Boss Zhipin <a href="#">Text version</a></p>

<pre><code>python3 -c "$(curl -fsSL #)"</code></pre>

</details>

<details>
<summary>Platform Hot Search and Rumor Refutation Summary and Analysis</summary>

Prerequisite: Before starting, first copy and run the following command to install the pip package. Data involving Stanford University’s language model [stanza](https://stanfordnlp.github.io/stanza) requires an external network connection.

<pre><code>pip3 install --no-cache-dir -r #
</code></pre>

<h3>Hot Search Collection and Analysis for Toutiao, Douyin, Weibo</h3>

<p>One-click collect today’s hot searches from Toutiao, Douyin, and Weibo. <a href="#">Text version</a> (NLP: Stanza)</p>

<pre><code>python3 -c "$(curl -fsSL #)"
</code></pre>

<ul>
<li>Automated categorization; overall match rate: 84%~96% range.</li>
<li>Word frequency statistics; hot searches common across all three platforms indicate lasting public interest, with higher information density.</li>
<li>Sentiment average, sentiment value for each headline; main focus: the intensity of sentiment for manually pinned hot searches.</li>
<li>Part-of-speech analysis; highlights words likely to have guiding or implanted awareness components, such as excessive use of attributive and adverbial phrases, which are often promotional in nature.</li>
</ul>

<p>Weibo has the most noise in automated categorization, with low informational value, large amounts of superficial content, and higher distortion. The hot search headlines across platforms also have unmarked rumor components, so it's best to use the <a href="#">National Rumor Refutation Platform</a> for verification. Despite its heavy entertainment focus, Weibo's social media model allows rapid dissemination of information when social events trend, sparking public attention and discussion.</p>

<p>Recommended Papers:</p>

<ul>
<li>He Qi Mao, "The News Reading Service Function of Weibo Hot Search under the Big Data Background," Master's thesis in Journalism, Jilin University, March 2017.</li>
<li>Guoming Yu, "The Overall Situation and Structural Characteristics of Public Opinion in China under Big Data Analysis," Journal of Renmin University of China, Issue 5, 2013.</li>
<li>Xiaoxin Wang, "The Reading Tendencies of Audiences for Online News in China — Taking Baidu Hot Search Terms as an Example," "Today Media," Issue 9, 2013.</li>
<li>Nuo Xu, "Research on the 5W Extraction of Social Risk Events Based on Baidu Hot Search News Terms," "Systems Engineering Theory and Practice," Volume 40, Issue 2, 2022.</li>
</ul>

<h3>Automated Collection of Rumor Refutation Items and Language Analysis</h3>

<p>The function is generally similar to the previous example, performing grammatical analysis on high-frequency words. (NLP: ThuLAC)</p>

<pre><code>python3 -c "$(curl -fsSL #)"
</code></pre>

<p>urllib3: <a href="#">#</a></p>

<p>Definition of rumors: Gordom W. Allport and Leo Postman first defined rumors as propositions related to current events, circulated between people through oral media, lacking specific evidence to verify their accuracy. <span id="fn1"><a href="#fn1-black"><sup>1</sup></a></span></p>

<p>Concept of rumors: Essentially, rumors generally have two attributes: widespread dissemination and uncertainty. Based on this, this paper defines rumors as information that is widely spread and carries a high degree of uncertainty. "Uncertainty" mainly refers to the uncertainty about the truth of the information. <span id="fn2"><a href="#fn2-black"><sup>2</sup></a></span></p>

<p>Currently, among various rumors during emergencies, there are relatively few with clear malicious intent or with goals such as achieving political, economic, or other interests. Most rumors are formed out of fear and based on erroneous judgments. (Hu Qi, 2022) From the collected rumors analysis, the two largest categories are social topics and healthy eating, accounting for 48% and 43%, respectively.</p>

<p>However, the blending of multiculturalism and fragmented interpretations in the "post-truth" era has intensified the value divergence among the public, eroding the trust foundation. On one hand, the complex interests, diverse social ideologies, and various modes of communication intersect to create a diverse network culture in the "post-truth" era, increasing collisions and friction between mainstream and non-mainstream cultures. While non-mainstream cultures can be a beneficial supplement to mainstream culture, negative elements like "Buddhism culture," "internet celebrity culture," and "lying flat culture" often deviate from mainstream culture, especially distorting aesthetics and promoting money worship, which can mislead audiences with limited knowledge and experience, leading to political biases and eroding existing political trust. On the other hand, in the "post-truth" era, faced with an overwhelming amount of information, people tend to piece together facts and interpret the truth in fragmented ways. Once it concerns complex political rumors about social divisions, interest distribution, political corruption, and policy failures, people easily fall into continuously interpreting and reconstructing fragmented information, creating multiple "truths" that further ferment, thus causing frequent doubts about established political consensus, resulting in the loss of political trust and providing opportunities for the spread of rumors. <span id="fn3"><a href="#fn3-black"><sup>3</sup></a></span></p>

<p>Referring to Yang Yunyi and Zhao Xiqun, personal life mostly involves money matters such as food, clothing, housing, and transportation, and social division is a normal phenomenon. The differences between "individual-collective" and "collective-individual" are primarily centered on national construction. The following two pieces of information are worth researching:</p>

<ul>
<li><a href="#">Zhihu - How to view CCTV's new video "Only by working hard can one feel at ease, it’s the life belief of countless ordinary people"?</a></li>
<li><a href="#">Bilibili - They say I touch, they say I pose, who cares about the helplessness of workers?</a></li>
</ul>

<i><b>References</b></i><br><br>
<span id="fn1-black"><a href="#fn1">[1]</a> Hu Qi, "Psychological Mechanisms and Governance Paths of Online Rumors in the Era of Omnimedia," P135, 137, [J] Social Scientist, 2022(11)</span><br>
<span id="fn2-black"><a href="#fn2">[2]</a> Lei Xia, "Cognitive Dissonance and Correction Mechanism of Rumors in Elderly Groups," [J] Modern Communication, 2023(3)</span><br>
<span id="fn3-black"><a href="#fn3">[3]</a> Yang Yunyi, Zhao Xiqun, "Representation, Attribution, and Governance of Political Rumors in the 'Post-Truth' Era," P155, [J] Journal of Hunan University of Science and Technology (Social Science Edition), 2022(11)</span><br>

</details>


## Research on Bilibili/B-zhàn (popular video-sharing platform based in China) User Comments and Bullet Chats

The script provides the following features:

1. <b>Video Information:</b> Title, author, publication date, views, favourites, shares, total bullet chats, number of comments, video description, category, video link, and thumbnail link.
2. <b>Bullet Chat Analysis:</b> 100 bullet chats including sentiment score, parts of speech analysis, timestamp, and user ID.
3. <b>Top Comments:</b> 20 popular comments including number of likes, sentiment score, replies to the topic, member ID, member name, and comment time.
4. <b>Enhanced Features:</b> For bullet chats: Displays username, date of birth, registration date, number of fans, and number of accounts followed (requires cookies).
      * <b>For comments:</b> Shows the IP location of the commenting user (requires web interface).
6. <b>Output:</b>
   * Generates an Excel file (xlsx) including:
     * Median sentiment score of text,
     * Word frequency statistics,
     * Word cloud visualisation,
     * Bar charts.


<details>
<summary>Click for details</summary>

Prerequisite: Ensure that your basic library components are complete.

<pre><code>pip3 install --no-cache-dir -r #
</code></pre>

Then run the script <a href="#">Text version</a>

<pre><code>python3 -c "$(curl -fsSL #)"
</code></pre>

<h3>Basic Text Analysis</h3>

Stopword text clustering comprehensive statistical analysis, see the image below <span id="fn4"><a href="#fn4-black"><sup>1</sup></a></span>

<img src="#" />

<p>In fact, different stopword lists have their applicable scopes. Most educational institution corpora are based on academic literature, so stopword lists from institutions like Fudan and Sichuan University are more suited for documents and emails. In contrast, portal websites' corpora are more suited for news reports, each with its own characteristics.</p>

<p>Text mining and word segmentation statistics involve stopword issues, which are enhanced by integrating stopword lists from Harbin Institute of Technology, Sichuan University, and Baidu, as well as Fudan’s stopword list collected from CSDN, to strengthen the clustering effect of text on "economy," "society," and "literature" to better target keywords.</p>

Text analysis work content is shown in the referenced image <span id="fn5"><a href="#fn5-black"><sup>2</sup></a></span>. The objectives are similar, only the methods differ slightly, but the results are the same.

<img src="#" />

<i><b>References</b></i><br><br>
<span id="fn4-black"><a href="#fn4">[1]</a> Huang Jun, "The Emotional Impact of Workplace Abuse and Behavioral Responses, and the Spread of Social Media like Bilibili," P149, [J] Communication Innovation Research, 2021(12)</span><br>
<span id="fn5-black"><a href="#fn5">[2]</a> Guan Qin, Deng Sanhong, Wang Hao, "A Comparative Study of Common Stopword Lists for Chinese Text Clustering," P76, [J] Data Analysis and Knowledge Discovery, 2017(3) </span><br>
</details>

## Basic Research on Sociological Topics

This section focuses on analyzing internet news media and network community organization mobilization.

<details>
<summary>Click for details</summary>

<h4 id="h3view"><a href="#">Subculture Perspective Review and Bullet Screen Research</a></h4>

<p>Overall, in the post-emotional era, I realized that people's emotional experiences are diverse. Just based on the interviewees' quotes regarding topics like "shipping CPs" and "cute pets," it is concluded that some interviewees have simplistic, idealized thoughts. This is unreliable and cannot be generalized. A more realistic perspective should be that some interviewees may not care about such topics, or they haven't given them much attention or deeper understanding. Furthermore, the data cannot draw conclusions about the interviewees' emotions, thoughts, or behavioral logic; it only highlights certain connections. To clarify the truth and underlying logic of these matters, more time and effort need to be spent on research.</p>

<h4 id="h3view"><a href="#">Analysis of People's Livelihood and Timely Comment News Media and Audience Behavior</a></h4>

<h5>Positive Behavioral Role of People's Livelihood Commentary Media</h5>

<p>In a one-dimensional society<span id="fn6"><sup><a href="#fn6-black">1</a></sup></span>, people from different regions often face similar life difficulties and social disputes. Through media selection of typical people's livelihood cases, it is easy for the public to gain a personal experience, creating cross-regional emotional resonance. Timely commentary based on this follows the principle of seeking truth from facts, analyzing various public opinion hot topics scientifically and rationally, while proposing feasible and constructive plans for the future. To a certain extent, this alleviates social contradictions, guides public emotions, and helps open the people's minds. However, it is important to emphasize that the purpose of opening the people's minds is for them to develop critical thinking, independent thought, and objective analysis of problems. It highlights the need for social progress, not to belittle the intellectual level and capabilities of the public.</p>

<h5>Attribution of Focus Loss Phenomenon in People's Livelihood Commentary News Audiences</h5>

<p>On one hand, audiences receive people's livelihood and timely commentary information due to personal resonance, curiosity, and other factors. On the other hand, living in a risk society<span id="fn8"><sup><a href="#fn8-black">3</a></sup></span>, audiences develop a psychological rejection of serious content and need a topic for casual conversation and entertainment to relieve anxiety, seek pleasure, and simultaneously look for groups with similar interests. This can also explain my previous question: "Why do I see my colleagues handle daily work efficiently, but when it comes to TV dramas or news reports, they are like parrots with no opinions, like idiots?" In general, the phenomenon of losing focus in public opinion is inevitable and normal. The audience's curiosity about news headlines, their patience for waiting and deep thinking about events no longer meets the expectations of some audience members. With limited attention and energy, these audience members turn to other topics with entertainment value and casual discussions, like popcorn-style leisure entertainment (gossip), to relieve stress and gain pleasure.</p>

<h4 id="h3view"><a href="#">Analysis of the "Little Pink" Group</a></h4>

<p>The term "Little Pink" is used by the public to refer to the online patriotic youth group. "Little" refers to their young age, which makes them seem naive but full of energy and passionate; "Pink" refers to the unique way of expression on the internet, such as using cute language and various "kawaii" emoticons. Moreover, due to their youth, their life experiences have not yet shaped their minds; "Red" refers to the strong patriotism and love for the party and leader, which is commonly associated with the Chinese Communist Party in the Chinese context.<span id="fn9"><sup><a href="#fn9-black">4</a></sup></span></p>

<p>Liu Fang's definition of the "Little Pink" group is accurate. She further divides the group into different age ranges, social classes, and occupational backgrounds. Among those aged 18 to 24, the student group accounts for a large proportion of the "Little Pink," most of whom come from working-class families. However, prior to the popularity of the Old Bull Sail model, a significant number of "Little Pink" came from middle-class urban families, which also needs to be noted. In any case, both groups share a common characteristic: the "Little Pink" group has strong social consumption ability and purchasing power, bears relatively less social pressure, and is a beneficiary and witness to the increasing national power brought by China's reform and opening up.</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/Excalibra/scripts/blob/main/d-ipynb/Reading%20Research%20on%20Discourse%20Expression%20and%20Community%20Mobilization%20in%20the%20%27Diba%20Expedition%27%20Event.ipynb">Reading "Research on Discourse Expression and Community Mobilization in the 'Emperor Bar Expedition' Event"</a></h4>

<h5>Emperor Bar Expedition: Group Mobilization and Public Opinion Guidance</h5>

<p>When the culture of a group aligns with the values and goals they advocate, it forms a driving force that encourages group members to culturally identify with the Emperor Bar community from multiple perspectives and to engage in collective interaction. Through organized mobilization, Emperor Bar profoundly influences the values and thinking patterns of its members, thereby motivating their enthusiasm and unity to support collective activities within the community.</p>

<p>On internet platforms, the expression of nationalism has become a common phenomenon. Through shared symbols, behaviors, and establishing connections with others who share similar views, individuals express their identification with their country and ethnicity. This performance of identity politics is influenced by both the individual and external environmental factors. In the "Zhou Ziyu Incident," Emperor Bar fully utilized the connectivity of the internet, climbing rankings and driving traffic across platforms. By constructing a common "patriotism" and "nationalism" discourse, they mobilized and recruited participants. Although the "Emperor Bar Expedition" appeared to be well-organized, with participants adhering to commands, having clear departure times, discipline, and attack targets, and requiring the use of collective templates, in practice, the youth mobilized by the new discourse of Emperor Bar did not necessarily need to engage in deep logical thinking or provide arguments. Instead, the expedition became a festive and noisy game, aimed at creating a situation of collective enthusiasm. In this mobilization process, celebrity-related emoticons created a heightened atmosphere, combining stars with nationalist sentiment, further strengthening collective identification and mobilizing effects, stimulating emotional resonance among fans, and increasing their willingness to support and participate in collective actions.</p>

<p>Therefore, the "Emperor Bar Expedition" can be seen as an activity of collective mobilization and public opinion guidance, where the joint forces of symbols, discourse, and emotion mobilize fans to participate and support, forming a polarized group action force. This action gives network violence a "nationalism" and "patriotism" legitimized image, making it widely accepted and supported within the group.</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/Excalibra/scripts/blob/main/d-ipynb/Empirical%20Study%20on%20the%20Motivations%20of%20Digital%20Natives%27%20Online%20Lurking.ipynb">Reading "Empirical Study on the Motives of Digital Natives' Online Lurking"</a></h4>

<h5>Research Purpose and Significance</h5>

<p>Research Purpose (Micro):</p>
<ol>
<li>Define the concepts of "lurkers" and "digital native lurkers" to eliminate the ambiguous definition of lurking.</li>
<li>Construct a motive model for lurking behavior and propose hypotheses explaining the motivations behind digital natives' lurking behavior.</li>
<li>Clarify the main influencing factors and their interrelationships.</li>
<li>Provide more effective suggestions for network operators and community managers.</li>
</ol>
<p>Research Significance (Macro):</p>
<p>1. Theoretical Significance: Review relevant theories used in the study of lurking from sociology, economics, and psychology, and build a theoretical framework for lurking research to provide theoretical support for future researchers.</p>
<p>2. Practical Significance: The practical significance of studying digital natives' lurking behavior mainly lies in economic benefits, the sustainable development of the internet, and collective intelligence.</p>

<h5>Based on "Theory of Planned Behavior", "Social Cultural Capital Theory", "Social Identity Theory", and statistical knowledge, the questionnaire design scheme</h5>

<p>Sample questionnaire design image<span id="fn10"><sup><a href="#fn9-black">5</a></sup></span></p> 

<img src="#" width="50%" height="50%"/>

<ul>
<li>Reliability Analysis: Focuses on whether the Cronbach's alpha value of each latent variable exceeds the critical value of 0.7.</li>
<li>Validity Analysis: Mainly based on exploratory factor analysis, statistical methods are used to judge whether the data has satisfactory construct validity.</li>
</ul>

</details>

## Windows Server Domain Controller

Script Locations:

* #
* #
Graphical Version:

* 【PowerShell】Batch Add Permissions Based on Text Content](#)
* 【PowerShell】Convert Folder Security Permissions to Corresponding Share Permissions (Project)](#)
* View Which Shared Folders a User Has Permissions for, and Remove Permissions](#)
* A Simple Domain Account Export Script (Requires Regex)](#)
* 【PowerShell】Add/Remove Domain Users, File Authorization, Organizational Units, and Domain User Recovery](#)

## Windows Desktop Technical Baseline Check

First, ensure that PowerShell is enabled on your system:

* **Enable PowerShell feature: `Set-ExecutionPolicy RemoteSigned`**
* **Disable PowerShell feature: `Set-ExecutionPolicy Restricted`**

<details>
<summary><b>Click for Details</b></summary>

One-click usage, local download with GB2312 encoding <a href="#">Graphical Version</a>

<pre><code>
irm #|iex
</code></pre>

Feature Overview:

<ol>
<li>Check IP and network device connectivity status</li>
<li>Check printer, print spooler, and scanner status</li>
<li>Check basic driver information for hard drives, CPUs, memory, graphics cards, etc.</li>
<li>Check device security, recent updates, scheduled tasks, certificate policies, system core file access control</li>
<li>Check host active sharing protocol-related information</li>
<li>Check computer sleep, reboot frequency, abnormal shutdown, program crashes, etc.</li>
<li>Execute all functions of options 1–6</li>
<li>Generate analysis reports for "Device Driver Check", "Five-Day Warning Events", "Login/Logout Activity Logs", "Monthly Threat Overview"</li>
<li>View guidance and development instructions</li>
</ol>

By the way

Linux baseline check (PR) can be found at: <a href="https://github.com/al0ne/LinuxCheck">al0ne/LinuxCheck</a>. For Macs, maintaining these security services is not suitable for small and medium-sized businesses.

<ul>
<li><a href="https://www.apple.com.cn/business/docs/site/Mac_Deployment_Overview.pdf">Apple - Mac System Deployment</a></li>
<li><a href="#">vmware - Correct Approach to Purchasing Apple Devices for Enterprises</a></li>
</ul>

In the broader context, this article <a href="#">CSDN - Three Methods to Manage Mac Computers in Enterprises</a> mentions management strategies that are considered effective, but compared to Windows, they are still not sufficient.

</details>

## Windows Enterprise Basic Environment Requirements

Main Involves:

* IE, Windows Defender, Windows Update, Flash & Chrome v87, DingTalk silent installation, automatic printer installation
* File checksum tools: MD5, SHA1, SHA256 hash calculation, comparison, verification tools.
* C drive space cleanup: DingTalk, WeChat, Foxmail local cache, Windows.old, Windows upgrade logs, files, etc. One-click cleanup script (C drive Thanos script).
* Basic skills required for job positions, IQ and EQ assessment, salary range summary, and demand analysis.

<details>
<summary><b>Click for Details</b></summary>

<p>Prevent Edge hijacking IE <a href="#">Graphical Version</a></p>

<pre><code>curl -L  #|cmd</code></pre>

<ul>
<li>Note【1】: <a href="#">Domain Controller IE Template Graphical Version</a></li>
<li>Note【2】: Code Address: <a href="#">#</a></li>
</ul>

<p>Calculate IE compatible view website hex, one-click usage, need to convert to GB2312 encoding for local use.</p>

<pre><code>
irm #|iex
</code></pre>

<p>One-click permanently disable Windows update settings <a href="#">Graphical Version</a></p>

<pre><code>curl -L  #|cmd</code></pre>

<p>One-click restore disabled Windows update settings</p>

<pre><code>curl -L  #|cmd</code></pre>

<p>One-click enable or disable Windows Defender real-time protection (discontinued, suggest using <a href="#">sordum.org/defender-control</a>)</p>

<pre><code>curl -OfsSL #&&call choice_wdrt.bat</code></pre>

<p>C drive Thanos script: One-click cleanup of DingTalk, WeChat, Foxmail local cache, Windows.old, Windows upgrade logs, files, etc.</p>

<pre><code>curl -OfsSL #</code></pre>

<p>One-click check if a program runs with administrator rights</p>

<pre><code>curl -OfsSL#</code></pre>

<p>One-click MD5, SHA1, SHA256 file verification tool</p>

<pre><code>curl -OfsSL #&&call md5tools.bat</code></pre>

<p>One-click install Flash and configure supported Chrome version 87</p>

<pre><code>curl -OfsSL #&&call fxxk_chxxa.bat</code></pre>

<p>One-click block Chrome browser updates</p>

<pre><code>curl -OfsSL #&&call deny_chrome_update.bat</code></pre>

<p>One-click PDF to PNG</p>

<pre><code>python3 -c "$(curl -fsSL #)"</code></pre>

<p>One-click fix for shared printer 0x11b error</p>

<pre><code>curl -OfsSL #&&call fix_0x11b_share_print.bat</code></pre>

<p>One-click retrieve job position information and reference material websites</p>

<pre><code>python3 -c "$(curl -fsSL #)"</code></pre>

<p> Install specified Chrome and block updates: <a href="#"> only_install_chrome65.bat </a>; DingTalk silent install source code: <a href="#">dingding</a></p>

</details>

## Various Management Maintenance Scripts

<details>
<summary><b>Click for Details</b></summary>

Complete tool, scripts, documentation</details>

</details>

## Linux Cloud Server Security Transformation

Cloud servers purchased from cloud service providers generally have no security software protection. Every day, cybercriminals scan public networks, attempting to remotely brute-force and invade servers. Therefore, preventive and defensive measures need to be taken.

<details>
<summary><b>Click for details</b></summary>

<h3>One-click configuration for SSH login, user password policy, and Ban IP setup <a href="#">Image & Text Version</a></h3>

<ul>
<li>SSH Login: Key-based login without password, long heartbeat connection to prevent client disconnection</li>
<li>Password Policy: No restrictions on special characters or case, supports minimum length of 4-5 characters</li>
<li>Ban IP: Permanently ban IP after three failed login attempts within 30 seconds, except for your own IP.</li>
</ul>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

<p>SSH single configuration: One-click SSH fast configuration for SSH key login policy and simple password rules. (The single configuration part restricts access to only your IP, i.e., AllowUsers)</p>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

<p>fail2ban single configuration: One-click fail2ban setup, from download to installation, configuration generation, and service start. (You can refresh your public IP configuration with the single part.)</p>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

<h3>One-click to create a custom user with admin privileges <a href="#">Image & Text Version</a></h3>

<ul>
<li>Custom username</li>
<li>No-password for su, sudo, and wheel group members</li>
<li>Lock root remote login in sshd_config to enhance security</li>
</ul>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

<h3>One-click FTP setup <a href="#">Image & Text Version</a></h3>

<ul>
<li>Shared directory: /var/ftp/share</li>
<li>Limit unauthorized access to shared directories, allowing read and write.</li>
<li>Secure, privatized, limited to your public IP access.</li>
</ul>

<p>No password version, username: ftpuser, password: P@ssw0rd</p>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

<p>Custom user version</p>

<pre><code>
sudo bash -c  "$(curl -fL #)"
</code></pre>

</details>

## Wallpaper Settings | Quick Web Pages

Work and live simultaneously.

<ol>
<li>Ruby must be version 3.0 or above</li>
<li>Ruby's integration on Windows is not as smooth as on Linux/macOS.</li>
<li>For this Ruby-based screen scraping and text processing, Ruby's library support is far less comprehensive than Python, suitable only for basic web scraping tasks.</li>
<li>If due to network conditions in certain countries, native writing should be avoided; instead, aria2 is used for downloading, to monitor the progress.</li>
</ol>

<details>
<summary><b>Click for details</b></summary>

<h3>Wallpaper Settings</h3>

<p>One-click Bing wallpaper downloader <a href="#">Image & Text Version</a></p>

<pre><code>python3 -c "$(curl -fsSL #)"</code></pre>

<p>One-click download of Microsoft official design wallpapers using Ruby</p>

<pre><code>ruby -e "$(curl -fsSL #)"</code></pre>

<p>One-click scheduled wallpaper change (Mac only)</p>

<pre><code>bash -c "$(curl -fsSL #)"</code></pre>

<h3>Quick Web Pages</h3>

<p>Windows web page opening tool</p>
<pre><code>curl -OfsSL #</code></pre>

<p>Mac web page opening tool</p>
<pre><code>bash -c "$(curl -fsSL #)"</code></pre>

</details>

## Fun Projects

This section contains fun projects created through my exploration, combining various online resources, source codes, and unique keys, reimagined and transformed into usable commands.

* Windows/Office, WinRAR, EmEditor, IDM, XchangePDF
* Wi-Fi, LAN IP viewer, Host IP operator and location lookup
* More...

<details>
<summary><b>Click for more details</b></summary>

<p>CMD one-click call to switch Windows versions and activate Windows/Office <a href="#">Image & Text Version</a></p>

<pre><code>curl -O #&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"</code></pre>

<p>CMD one-click install WinRAR registration and activation</p>

<pre><code>powershell -command Invoke-WebRequest -Uri "#" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users%username%\Downloads\winrar_down_reg.bat
</code></pre>

<p>Powershell one-click EmEditor serial key generator</p>

<pre><code>irm #|iex
</code></pre>

<p>Powershell one-click IDM activation (<a href="#">)</p>

<pre><code>iwr -useb # | iex
</code></pre>

<p>Powershell for generating XchangePDF Editor license</p>

<pre><code>curl # -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
</code></pre>

<p>Win7 "Insufficient Memory" error when opening images <a href="#">Image & Text Version</a></p>

<pre><code>powershell -c "irm  #" && exifhelper.bat
</code></pre>

</details>

## Small Utilities

Various small tools for convenience.

<details>
<summary><b>Click for more details</b></summary>

<p>Restore Win10 right-click menu or revert Win11 right-click menu</p>

<pre><code>curl -OfsSL #&&call right-menu.bat
</code></pre>

<p>Unlock application permission issues preventing deletion</p>

<pre><code>curl -OfsSL #&&call delete-error.bat
</code></pre>

<p>Prevent computer from going to sleep for a specific period (Great for remote work)</p>

<pre><code>curl -OfsSL #&&call stay-awake.bat
</code></pre>

<p>Memory and Disk Health Check for Windows</p>

<pre><code>curl -OfsSL #&&call win_memory_disk.bat
</code></pre>

<p>Check Windows system login users and allow remote login</p>

<pre><code>curl -OfsSL #&&call check-users.bat
</code></pre>

</details>

---
***Thank you for viewing. Here are the [Latex Demo](https://www.overleaf.com/read/khdnbtjxwkzx) for fellow enthusiasts.***

