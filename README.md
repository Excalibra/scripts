## Disclaimer: All content is for informational research, learning, and exchange purposes only, to be used in a lawful and compliant manner. Thank you.

## Introduction

The project involves interdisciplinary applications and analysis of information: desktop baseline checks, software activation/cracking, antivirus evasion and privilege escalation, firmware identification and read/write for penetration support, host account null password detection, Wi-Fi password scanning, cloud host security hardening, host system log analysis, natural language processing, and data analysis in humanities and social sciences.

* **System Platforms**: Windows/Mac/Linux; **Scripting Languages**: Multiple, flexible; customized as needed.
* **Research Focus**: Basic information automation, cloud host/local desktop security processing, social science information technology, and data analysis.

The project code involves component version compatibility issues. <a href="https://nbviewer.org/github/Excalibra/scripts/blob/main/d-ipynb/Platform%20Compatibility%20Issues.ipynb">Click here</a> for more details; regarding the inability to preview ipynb on GitHub, [please refer here](https://blog.reviewnb.com/jupyter-notebook-not-rendering-on-github/); to generate automated information processing reports, check the [d-xlsx](./d-xlsx) directory for more details.

## Windows Server Domain Controller

Daily operation records of a domain administrator.

<details>
<summary><b>Click for details</b></summary>
Script Locations:

* https://github.com/Excalibra/scripts/tree/main/d-python-dc
* https://github.com/Excalibra/scripts/tree/main/d-pwsh-dc

     
Illustrated Versions:

* [Code for adding watermarks to domain controller computer screens, suitable for intranet office environments](https://github.com/Excalibra/scripts/tree/main/d-python-dc/watermark)
* [DEV - 【PowerShell】Batch add permissions based on text content](https://dev.to/excalibra/powershell-batch-adding-related-permissions-based-on-text-content-5dbk)
* [DEV - 【PowerShell】Convert NTFS folder security permissions to corresponding shared permissions (project)](https://dev.to/excalibra/powershell-convert-folder-security-permissions-to-corresponding-share-permissions-project-20f0)
* [DEV - Check which shared folders a user has permissions for and remove those permissions](#)
* [DEV - A simple domain account export script note (requires regex)](#)
* [DEV - 【PowerShell】Domain user management, file authorization, organizational unit, and domain user restoration](#)

</details>

## Windows Desktop Technical Baseline Check

First, ensure that PowerShell is enabled on your system:

* **Enable PowerShell feature: `Set-ExecutionPolicy RemoteSigned`**
* **Disable PowerShell feature: `Set-ExecutionPolicy Restricted`**

<details>
<summary><b>Click for Details</b></summary>

One-click usage, local download <a href="https://dev.to/excalibra/script-for-checking-windows-baselines-c3i">Graphical Version</a>

<pre><code>
irm https://ghfast.top/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-pwsh/frontline_helpdesk.ps1|iex</code></pre>

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
<li><a href="https://www.apple.com/business/docs/site/Mac_Deployment_Overview.pdf">Apple - Mac System Deployment</a></li>
<li><a href="https://excalibra.github.io/2025/01-22/01">vmware - Correct Approach to Purchasing Apple Devices for Enterprises</a></li>
</ul>

In the broader context, this article <a href="https://excalibra.github.io/2025/01-22/01">Three Methods to Manage Mac Computers in Enterprises</a> mentions management strategies that are considered effective, but compared to Windows, they are still not sufficient.

</details>

## Windows Enterprise Basic Environment Requirements

Main Involves:

* IE, Windows Defender, Windows Update, Flash & Chrome v87, DingTalk silent installation, automatic printer installation
* File checksum tools: MD5, SHA1, SHA256 hash calculation, comparison, verification tools.
* C drive space cleanup: Application local cache, Windows.old, Windows upgrade logs, files, etc. One-click cleanup script (C drive Thanos script).
* Basic skills required for job positions, IQ and EQ assessment, salary range summary, and demand analysis.

<details>
<summary><b>Click for Details</b></summary>

<p>Prevent Edge hijacking IE <a href="#">Graphical Version</a></p>

<pre><code>curl -L  https://ghfast.top/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-bat/keep_ie.bat|cmd</code></pre>

<ul>
<li>Note【1】: <a href="https://dev.to/excalibra/batch-processing-for-setting-ie-homepage-trusted-security-zones-compatibility-view-and-m1j">Domain Controller IE Template Graphical Version</a></li>
<li>Note【2】: Code Address: <a href="https://github.com/Excalibra/scripts/blob/main/d-bat/ie-kanzen.bat">https://github.com/Excalibra/scripts/blob/main/d-bat/ie-kanzen.bat</a></li>
</ul>

<p>Calculate IE compatible view website hex, one-click usage.</p>

<pre><code>
irm https://ghfast.top/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-pwsh/clac_ie_clearablelistdata_hex.ps1|iex
</code></pre>

<p>One-click permanently disable Windows update settings <a href="https://dev.to/excalibra/overview-of-creating-a-batch-file-to-disable-windows-updates-3ami">Graphical Version</a></p>

<pre><code>curl -L  https://ghfast.top/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-bat/stop_update.bat|cmd</code></pre>

<p>One-click restore disabled Windows update settings</p>

<pre><code>curl -L  https://ghfast.top/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-bat/re_update.bat|cmd</code></pre>

<p>One-click enable or disable Windows Defender real-time protection (discontinued, suggest using <a href="https://www.sordum.org/9480/defender-control-v2-1/">sordum.org/defender-control</a>)</p>

<pre><code>curl -OfsSL</code></pre>

<p>C Drive Cleaner Script: One-click cleanup for local cache files from Foxmail, Windows.old, Windows upgrade logs, and other files.</p>

<pre><code>curl -OfsSL #</code></pre>

<p>One-click check if a program runs with administrator rights</p>

<pre><code>curl -OfsSL#</code></pre>

<p>One-click MD5, SHA1, SHA256 file verification tool</p>

<pre><code>curl -OfsSL #&&call md5tools.bat</code></pre>

<p>One-click install Flash and configure supported Chrome version 87</p>

<pre><code>curl -OfsSL # </code></pre>

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

<p>One-click generate global information reports <a href="https://dev.to/excalibra/python-original-created-a-web-scraper-for-worldmeterinfo-25c4">Text version</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://github.com/Excalibra/scripts/blob/main/d-python/get_worldometers.py)"
</code></pre>

<p>One-click collect the top posts on Reddit </p>
<pre><code>python3 -c "$(curl -fsSL https://raw.githubusercontent.com/Excalibra/scripts/blob/main/d-python/reddit_data_demo.py)"</code></pre>

<p>Collect 90 job posts and salary details HH.ru <a href="https://dev.to/excalibra/python-orighinal-sozdal-diemo-vieb-skrieipiera-dlia-saita-vakansii-46if">Text version</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://github.com/Excalibra/scripts/blob/main/d-python/hh.ru_demo.py)"</code></pre>

</details>

<details>
<summary>Platform Hot Search and Rumor Refutation Summary and Analysis</summary>

Prerequisite: Before starting, first copy and run the following command to install the pip package. Data involving Stanford University’s language model [stanza](https://stanfordnlp.github.io/stanza) requires an external network connection.

<pre><code>pip3 install --no-cache-dir -r https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/main/d-txt/requirements.txt
</code></pre>

<h3>Draft - Hot Search Collection and Analysis for #1, #2, #3</h3>

<p>One-click collect today’s hot searches from #1, #2, and #3 <a href="#">Text version</a> (NLP: Stanza)</p>

<pre><code>python3 -c "$(curl -fsSL #)"
</code></pre>

<ul>
<li>Automated categorization; overall match rate: 84%~96% range.</li>
<li>Word frequency statistics; hot searches common across all three platforms indicate lasting public interest, with higher information density.</li>
<li>Sentiment average, sentiment value for each headline; main focus: the intensity of sentiment for manually pinned hot searches.</li>
<li>Part-of-speech analysis; highlights words likely to have guiding or implanted awareness components, such as excessive use of attributive and adverbial phrases, which are often promotional in nature.</li>
</ul>

<p># has the most noise in automated categorization, with low informational value, large amounts of superficial content, and higher distortion. The hot search headlines across platforms also have unmarked rumor components, so it's best to use the <a href="#">National Rumor Refutation Platform</a> for verification. Despite its heavy entertainment focus, # social media model allows rapid dissemination of information when social events trend, sparking public attention and discussion.</p>

<h3>Automated Collection of Rumor Refutation Items and Language Analysis</h3>

<p>The function is generally similar to the previous example, performing grammatical analysis on high-frequency words. (NLP: ThuLAC)</p>

<pre><code>python3 -c "$(curl -fsSL #)"
</code></pre>

<p>urllib3: <a href="#">#</a></p>

<p>Definition of rumors: Gordom W. Allport and Leo Postman first defined rumors as propositions related to current events, circulated between people through oral media, lacking specific evidence to verify their accuracy. <span id="fn1"><a href="#fn1-black"><sup>1</sup></a></span></p>

<p>Concept of rumors: Essentially, rumors generally have two attributes: widespread dissemination and uncertainty. Based on this, this paper defines rumors as information that is widely spread and carries a high degree of uncertainty. "Uncertainty" mainly refers to the uncertainty about the truth of the information. <span id="fn2"><a href="#fn2-black"><sup>2</sup></a></span></p>

<p>Currently, among various rumors during emergencies, there are relatively few with clear malicious intent or with goals such as achieving political, economic, or other interests. Most rumors are formed out of fear and based on erroneous judgments. (Hu Qi, 2022) From the collected rumors analysis, the two largest categories are social topics and healthy eating, accounting for 48% and 43%, respectively.</p>

<p>However, the blending of multiculturalism and fragmented interpretations in the "post-truth" era has intensified the value divergence among the public, eroding the trust foundation. On one hand, the complex interests, diverse social ideologies, and various modes of communication intersect to create a diverse network culture in the "post-truth" era, increasing collisions and friction between mainstream and non-mainstream cultures. While non-mainstream cultures can be a beneficial supplement to mainstream culture, negative elements like "Buddhism culture," "internet celebrity culture," and "lying flat culture" often deviate from mainstream culture, especially distorting aesthetics and promoting money worship, which can mislead audiences with limited knowledge and experience, leading to political biases and eroding existing political trust. On the other hand, in the "post-truth" era, faced with an overwhelming amount of information, people tend to piece together facts and interpret the truth in fragmented ways. Once it concerns complex political rumors about social divisions, interest distribution, political corruption, and policy failures, people easily fall into continuously interpreting and reconstructing fragmented information, creating multiple "truths" that further ferment, thus causing frequent doubts about established political consensus, resulting in the loss of political trust and providing opportunities for the spread of rumors. <span id="fn3"><a href="#fn3-black"><sup>3</sup></a></span></p>


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

<pre><code>pip3 install --no-cache-dir -r https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-txt/requirements.txt
</code></pre>

Then run the script <a href="https://dev.to/excalibra/python-a-script-for-processing-and-analysing-bilibili-video-comments-and-bullet-chats-3egc">Text version</a>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://github.com/Excalibra/scripts/blob/main/d-python/get_bv_baseinfo.py)"
</code></pre>

<h3>Basic Text Analysis</h3>

Stopword text clustering comprehensive statistical analysis, see the image below <span id="fn4"><a href="#fn4-black"><sup>1</sup></a></span>

<img src="#" />

<p>In fact, different stopword lists have their applicable scopes. Most educational institution corpora are based on academic literature, so stopword lists from institutions like Fudan and Sichuan University are more suited for documents and emails. In contrast, portal websites' corpora are more suited for news reports, each with its own characteristics.</p>

<p>Text mining and word segmentation statistics involve stopword issues, which are enhanced by integrating stopword lists from Harbin Institute of Technology, Sichuan University, and Baidu, as well as Fudan’s stopword list collected from CSDN, to strengthen the clustering effect of text on "economy," "society," and "literature" to better target keywords.</p>

Text analysis work content is shown in the referenced image <span id="fn5"><a href="#fn5-black"><sup>2</sup></a></span>. The objectives are similar, only the methods differ slightly, but the results are the same.

<img src="#" />

</details>

## Basic Research on Sociological Topics

This section focuses on analyzing internet news media and network community organization mobilization.

<details>
<summary>Click for details</summary>

<h4 id="h3view"><a href="#">Subculture Perspective Review and Bullet Screen Research</a></h4>

<p>Overall, in the post-emotional era, I have come to realise that people's emotional experiences are diverse. Based solely on the interviewees' quotes regarding topics such as "romantic pairing fandoms" (commonly referred to as "shipping" — where fans enthusiastically support the idea of two characters, real or fictional, being in a romantic relationship) and "cute pets," it can be concluded that some interviewees hold simplistic, idealised views. This is unreliable and cannot be generalised. A more realistic perspective would suggest that some interviewees may not care about these topics, or they may not have given them much attention or a deeper understanding. Moreover, the data cannot provide definitive conclusions about the interviewees' emotions, thoughts, or behavioural logic; it merely points to certain connections. To uncover the truth and the underlying logic of these matters, further time and effort must be invested in research.</p>


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

<li>Reliability Analysis: This primarily examines whether the Cronbach's alpha value of each latent variable exceeds the critical value of 0.7.</li>

<li>Validity Analysis: This is mainly tested through factor analysis, specifically by performing a KMO (Kaiser-Meyer-Olkin) coefficient analysis on the sample data. Kaiser provided commonly used KMO measurement standards:</li>


- Above 0.9 indicates excellent suitability,
- 0.8 indicates good suitability,
- 0.7 indicates average suitability,
- 0.6 indicates low suitability, and
- Below 0.5 indicates very poor suitability.

<li>Factor Correlation Analysis: Bartlett's test of sphericity is used to examine whether there is a correlation among the observed variables. This is a prerequisite for conducting factor analysis. The test is based on the null hypothesis that there is no correlation among the observed variables. If the significance level obtained from Bartlett's test of sphericity is low (commonly set at 0.05), the null hypothesis can be rejected, indicating that there is a correlation among the observed variables and that factor analysis is suitable.</li>

<li>Scale Granularity Analysis: The Likert scale typically has 5 or 7 levels, but other numbers can also be used. Choosing an appropriate range of levels should consider the ease with which respondents can understand and answer. Fewer levels may restrict respondents when selecting a neutral option, while more levels may increase the complexity of their choices.</li>

Exploratory Analysis:

1. How many government officials read Marx, and how many believe in Marx?
2. Conduct a comprehensive analysis of employment, including individuals, enterprises, and related fraud cases.







</details>

Exploratory Analysis:

- How many government officials read Marx, and how many believe in Marx?
- Conduct a comprehensive analysis of employment, including individuals, enterprises, and related fraud cases.

<details> 
<summary>Click for details</summary>
<h4 id="h3view"><a href="https://nbviewer.org/github/Excalibra/scripts/refs/heads/main/d-ipynb/Reading On the Reasons for the Decline of Marxism's Prestige.ipynb">Reading “On the Reasons for the Decline in the Prestige of Marxism”</a></h4> 

<h5>Reasons for the decline in Marxism's prestige:</h5>

<p>Negative factors: 1. The failure of the Soviet-style socialist system dealt a significant blow. 2. The behaviour of some Communist Party officials and Marxist theorists, which contradicted their principles, severely damaged Marxism's reputation. 3. Many people do not understand Marxism well, cannot apply it, and fail to solve practical problems. 4. The rejection of Marxist theories by certain individuals has also contributed to its decline.</p>

<p>Positive factors: 1. Horizontally, reforms and opening up have broadened our theoretical perspectives, reducing the relative importance of Marxism. 2. Vertically, the creation of new theories such as socialism with Chinese characteristics has further diminished Marxism's relative significance. 3. People are increasingly adopting a scientific and analytical approach to Marxist teachings, causing its prestige to fall from its peak.</p> <h4 id="h3view"><a href="https://nbviewer.org/github/Excalibra/scripts/refs/heads/main/d-ipynb/Employment Situation Analysis and Fraud Prevention Strategies.ipynb">Analysis of Employment Trends and Fraud Prevention Strategies</a></h4> <h4>Core Motivations of Fraudsters</h4> <p>We are surrounded by grand narratives and emotional reflections, but what we often lack is “the facts themselves.” Today, things have improved compared to the past, where information dissemination was limited to search engines and web portals. Now, with the advent of social media and greater public scrutiny, transparency has increased. However, this also introduces a new challenge: the prevalence of review moderation and content control. Given the current system and structure in our country, the overall outlook remains challenging. Our understanding is largely shaped by the cost others pay and the information disclosed.

- The fraudster’s objectives are diverse, including obtaining money, controlling individuals, or acquiring labour.
- The job seeker's objective is relatively singular: providing labour in exchange for money.

It is worth noting that both fraudsters and job seekers are ultimately seeking to acquire money from one another. This creates a zero-sum game based on incomplete information.

Fraudsters, with their varied objectives and preferences, have a broad range of strategies and approaches. They exhaust all possible means to maximise their benefits. The core strategy of fraudsters is to target specific contexts and scenarios, aiming to acquire the worker's money either before or after they perform labour.</p>
<h4>Fraudsters' Construction of Belief and Fraud Implementation</h4> <p>For fraudsters, whether they succeed in deceiving a job seeker is a matter of probability. Job seekers come from various backgrounds, and their behaviour is unpredictable. However, one critical point must be noted: fraudsters succeed in deceiving those who believe they are not fraudsters. In other words, the key to fraudsters' success lies in building trust with the job seekers.

Although each individual's actions are unpredictable, fraudsters employ various methods to create a specific sense of scarcity, which fosters trust. Using this trust, they can introduce conditions to manipulate the job seeker's intentions and behaviour.

Specifically, fraudsters often apply social psychology to construct dilemmas and staged scenarios to influence the thoughts and emotions of job seekers. They frequently highlight limited job openings, urgent deadlines, special insider opportunities, or other forms of scarcity to stimulate competitiveness and desire among job seekers, pushing them to make quick decisions.

Once trust is established in these high-pressure scenarios, fraudsters often ask job seekers to demonstrate their “sincerity” and “willingness to cooperate.” At this stage, fraudsters may request personal information, payment of fees, or completion of specific tasks. While these requests may seem reasonable, they are, in fact, aimed at obtaining sensitive information or economic gain from the job seeker.</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/Excalibra/scripts/refs/heads/main/d-ipynb/Empirical Study on the Motivations of Digital Natives' (Users) Online Lurking.ipynb">Empirical Study on the Motivations of Digital Natives' (Users) Online Lurking
</a></h4>

</details> 

## Various Management Maintenance Scripts

<details>
<summary><b>Click for Details</b></summary>

Complete tool, scripts, documentation</details>

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

<p>One-click Bing wallpaper downloader <a href="https://dev.to/excalibra/entry-level-bing-wallpaper-scraper-7pg">Image & Text Version</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-python/get_bing_wallpapers.py)"</code></pre>

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

<p>CMD one-click call to switch Windows versions and activate Windows/Office</p>

<pre><code>curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"</code></pre>

<p>CMD one-click install WinRAR registration and activation</p>

<pre><code>powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://github.com/Excalibra/scripts/raw/refs/heads/main/d-bat/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users%username%\Downloads\winrar_down_reg.bat
</code></pre>

<p>Powershell one-click EmEditor serial key generator</p>

<pre><code>irm https://ghproxy.com/https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-pwsh/emeditor_random_keygen.ps1|iex
</code></pre>

<p>Powershell one-click IDM activation</p>

<pre><code>iwr -useb https://ghproxy.com/https://raw.githubusercontent.com/lstprjct/IDM-Activation-Script/main/IAS.ps1 | iex
</code></pre>


</details>

## Small Utilities

Various small tools for convenience.

<details>
<summary><b>Click for more details</b></summary>

<p>Restore Win10 right-click menu or revert Win11 right-click menu</p>

<pre><code>curl -OfsSL https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-bat/right-menu.bat&&call right-menu.bat
</code></pre>

<p>Unlock application permission issues preventing deletion</p>

<pre><code>curl -OfsSL https://raw.githubusercontent.com/Excalibra/scripts/refs/heads/main/d-bat/unlockapp.bat&&call delete-error.bat
</code></pre>

</details>

---
***Thank you for viewing. Here are the [LaTex Demo](https://www.overleaf.com/read/khdnbtjxwkzx) for fellow enthusiasts.***

